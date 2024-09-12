package io.github.isacgalvao.sistema.turmas.entities;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.github.isacgalvao.sistema.aluno.entities.Aluno;
import io.github.isacgalvao.sistema.professor.entities.Professor;
import io.github.isacgalvao.sistema.turmas.dto.CreateTurma;
import io.github.isacgalvao.sistema.turmas.dto.UpdateTurma;
import jakarta.persistence.CascadeType;
import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapKeyColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "turmas")
@Data
public class Turma {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String nome;

    @Column(nullable = false, length = 100)
    private String disciplina;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "turmas_alunos",
        joinColumns = @JoinColumn(name = "turma_id"),
        inverseJoinColumns = @JoinColumn(name = "aluno_id")
    )
    private List<Aluno> alunos;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "professor_id", nullable = false)
    private Professor professor;

    @JsonIgnore
    @OneToMany(mappedBy = "turma", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Presenca> presencas;

    @JsonIgnore
    @OneToMany(mappedBy = "turma", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Anotacao> anotacoes;

    @JsonIgnore
    @OneToMany(mappedBy = "turma", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Avaliacao> avaliacoes;

    @ElementCollection
    @CollectionTable(name = "resultados_finais")
    @MapKeyColumn(name = "aluno_id")
    @Column(name = "nota_final")
    private Map<Long, Double> resultadosFinais = new HashMap<>();

    @Column(nullable = false)
    private Double notaMinima;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private SituacaoTurma situacao;

    @Column(nullable = false)
    private Date dataCriacao;

    public static Turma of(Long idProfessor, CreateTurma dto) {
        Turma turma = new Turma();
        turma.setNome(dto.nome());
        turma.setDisciplina(dto.disciplina());
        turma.setDataCriacao(new Date());
        turma.setNotaMinima(dto.notaMinima());
        turma.setSituacao(SituacaoTurma.ATIVA);
        turma.setAlunos(dto.alunos().stream().map(Aluno::of).toList());
        turma.setProfessor(Professor.of(idProfessor));
        return turma;
    }

    public static Turma of(Long idTurma) {
        Turma turma = new Turma();
        turma.setId(idTurma);
        return turma;
    }

    public Turma merge(UpdateTurma dto) {
        if (dto.nome() != null && !dto.nome().isBlank()) {
            this.nome = dto.nome();
        }

        if (dto.disciplina() != null && !dto.disciplina().isBlank()) {
            this.disciplina = dto.disciplina();
        }

        return this;
    }

    public void adicionarAlunos(Long alunoId) {
        if (this.alunos == null) {
            this.alunos = new ArrayList<>();
        }
        this.alunos.add(Aluno.of(alunoId));
    }

    public void consolidar() {
        this.situacao = SituacaoTurma.CONCLUIDA;

        Map<Long, List<Nota>> notasAgrupadas = this.avaliacoes.stream()
            .flatMap(a -> a.getNotas().stream())
            .collect(Collectors.groupingBy(n -> n.getAluno().getId()));
        
        Map<Long, Double> notasFinais = new HashMap<>();
        for (var entry : notasAgrupadas.entrySet()) {
            List<Nota> notas = entry.getValue();
            double notaFinal = notas.stream().mapToDouble(Nota::getValor).average().orElse(0);
            notasFinais.put(entry.getKey(), notaFinal);
        }

        this.resultadosFinais = notasFinais;
    }
}
