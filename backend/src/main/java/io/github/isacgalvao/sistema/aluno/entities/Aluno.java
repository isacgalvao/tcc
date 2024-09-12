package io.github.isacgalvao.sistema.aluno.entities;

import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.github.isacgalvao.sistema.aluno.dto.CreateAluno;
import io.github.isacgalvao.sistema.aluno.dto.UpdateAluno;
import io.github.isacgalvao.sistema.professor.entities.Professor;
import io.github.isacgalvao.sistema.turmas.entities.Nota;
import io.github.isacgalvao.sistema.turmas.entities.Turma;
import io.github.isacgalvao.sistema.utils.BCryptUtils;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "alunos")
@Data
public class Aluno {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String nome;

    @Column(length = 100)
    private String email;

    @Column(length = 100)
    private String usuario;

    @JsonIgnore
    @Column(length = 100)
    private String senha;

    @Column(length = 20)
    private String telefone;
    
    @Column
    private LocalDate dataNascimento;

    @JsonIgnore
    @ManyToMany(mappedBy = "alunos")
    private List<Turma> turmas;

    @JsonIgnore
    @OneToMany(mappedBy = "aluno")
    private List<Nota> notas;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "professor_id", nullable = false)
    private Professor owner;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private SituacaoAluno situacao;

    public static Aluno of(Long id) {
        Aluno aluno = new Aluno();
        aluno.setId(id);
        return aluno;
    }

    public static Aluno of(CreateAluno dto) {
        Aluno aluno = new Aluno();
        aluno.setNome(dto.nome());
        aluno.setEmail(dto.email());
        aluno.setTelefone(dto.telefone());
        aluno.setDataNascimento(dto.dataNascimento());
        aluno.setSituacao(SituacaoAluno.ATIVO);
        aluno.setOwner(Professor.of(dto.professorId()));
        return aluno;
    }

    public Aluno merge(UpdateAluno dto) {
        if (dto.nome() != null) {
            this.setNome(dto.nome());
        }
        if (dto.email() != null) {
            this.setEmail(dto.email());
        }
        if (dto.telefone() != null) {
            this.setTelefone(dto.telefone());
        }
        if (dto.dataNascimento() != null) {
            this.setDataNascimento(dto.dataNascimento());
        }
        if (dto.situacao() != null) {
            this.setSituacao(dto.situacao());
        }
        if (dto.senha() != null) {
            if (!dto.senha().isBlank()) {
                this.setSenha(BCryptUtils.getInstance().hash(dto.senha()));
            } else {
                this.setSenha(null);
            }
        }
        if (dto.usuario() != null) {
            this.setUsuario(dto.usuario());
        }
        return this;
    }
}

