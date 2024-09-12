package io.github.isacgalvao.sistema.turmas.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.github.isacgalvao.sistema.aluno.entities.Aluno;
import io.github.isacgalvao.sistema.turmas.dto.CreateNota;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "notas")
@Data
public class Nota {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Double valor;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "avaliacao_id", nullable = false)
    private Avaliacao avaliacao;

    @ManyToOne
    @JoinColumn(name = "aluno_id", nullable = false)
    private Aluno aluno;

    public static Nota of(CreateNota dto) {
        Nota nota = new Nota();
        nota.setValor(dto.valor());
        nota.setAluno(Aluno.of(dto.alunoId()));
        return nota;
    }
}
