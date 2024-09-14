package io.github.isacgalvao.sistema.professor.entities;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.github.isacgalvao.sistema.aluno.entities.Aluno;
import io.github.isacgalvao.sistema.professor.ProfessorConstraints;
import io.github.isacgalvao.sistema.professor.dto.CreateProfessor;
import io.github.isacgalvao.sistema.professor.dto.UpdateProfessor;
import io.github.isacgalvao.sistema.turmas.entities.Turma;
import io.github.isacgalvao.sistema.utils.BCryptUtils;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "professores")
@Data
public class Professor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = ProfessorConstraints.Nome.MAX_SIZE)
    private String nome;

    @Column(nullable = false, length = ProfessorConstraints.Email.MAX_SIZE, unique = true)
    private String email;

    @Column(nullable = false, length = ProfessorConstraints.Usuario.MAX_SIZE, unique = true)
    private String usuario;

    @JsonIgnore
    @Column(nullable = false, length = ProfessorConstraints.Password.MAX_SIZE)
    private String senha;

    @OneToMany(mappedBy = "owner", fetch = FetchType.EAGER)
    private List<Aluno> alunos;

    @JsonIgnore
    @OneToMany(mappedBy = "professor")
    private List<Turma> turmas; 

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private SituacaoProfessor situacao;

    public Professor merge(UpdateProfessor dto) {
        if (dto.nome() != null && !dto.nome().isBlank()) {
            this.setNome(dto.nome());
        }

        if (dto.email() != null && !dto.email().isBlank()) {
            this.setEmail(dto.email());
        }

        if (dto.usuario() != null && !dto.usuario().isBlank()) {
            this.setUsuario(dto.usuario());
        }

        if (dto.senha() != null && !dto.senha().isBlank()) {
            this.setSenha(BCryptUtils.getInstance().hash(dto.senha()));
        }

        return this;
    }

    public static Professor of(CreateProfessor dto) {
        Professor entity = new Professor();
        entity.setNome(dto.nome());
        entity.setEmail(dto.email());
        entity.setUsuario(dto.usuario());
        entity.setSenha(BCryptUtils.getInstance().hash(dto.senha()));
        entity.setSituacao(SituacaoProfessor.ATIVO);
        return entity;
    }

    public static Professor of(Long id) {
        Professor entity = new Professor();
        entity.setId(id);
        return entity;
    }
}
