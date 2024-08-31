package io.github.isacgalvao.sistema.aluno.entities;

import java.util.Set;

import io.github.isacgalvao.sistema.turmas.entities.Turma;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
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

    @Column(length = 100)
    private String senha;

    @ManyToMany(mappedBy = "alunos")
    private Set<Turma> turmas;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private SituacaoAluno situacao;
}

