package io.github.isacgalvao.sistema.turmas.entities;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.github.isacgalvao.sistema.aluno.entities.Aluno;
import io.github.isacgalvao.sistema.turmas.dto.CreatePresenca;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "presencas")
@Data
public class Presenca {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Date data;

    @JsonIgnore
    @JoinColumn(name = "turma_id")
    @ManyToOne
    private Turma turma;

    @JoinColumn(name = "aluno_id")
    @ManyToOne
    private Aluno aluno;

    @Column
    private String justificativa;

    public static Presenca of(Long id) {
        Presenca presenca = new Presenca();
        presenca.setId(id);
        return presenca;
    }

    public static Presenca of(Long turmaId, CreatePresenca dto) {
        Presenca presenca = new Presenca();
        presenca.setAluno(Aluno.of(dto.alunoId()));
        presenca.setData(dto.data());
        presenca.setTurma(Turma.of(turmaId));
        presenca.setJustificativa(dto.justificativa());
        return presenca;
    }
}
