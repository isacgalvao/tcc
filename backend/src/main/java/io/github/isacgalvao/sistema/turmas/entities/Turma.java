package io.github.isacgalvao.sistema.turmas.entities;

import java.util.Set;

import io.github.isacgalvao.sistema.aluno.entities.Aluno;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
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

    @Column(nullable = false)
    private Integer ano;

    @Column(nullable = false)
    private Integer periodosAvaliativos;

    @ManyToMany
    @JoinTable(
        name = "turmas_alunos",
        joinColumns = @JoinColumn(name = "turma_id"),
        inverseJoinColumns = @JoinColumn(name = "aluno_id")
    )
    private Set<Aluno> alunos;

    @Column(length = 500)
    private String observacoes;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private SituacaoTurma situacao;
}
