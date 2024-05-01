package io.github.isacgalvao.sistema.professor.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.github.isacgalvao.sistema.professor.ProfessorConstraints;
import io.github.isacgalvao.sistema.professor.dto.CreateProfessor;
import io.github.isacgalvao.sistema.professor.dto.UpdateProfessor;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
            // FIXME - Deve-se utilizar um encoder para a senha
            this.setSenha(dto.senha());
        }

        return this;
    }

    public static Professor of(CreateProfessor dto) {
        Professor entity = new Professor();
        entity.setNome(dto.nome());
        entity.setEmail(dto.email());
        entity.setUsuario(dto.usuario());
        // FIXME - Deve-se utilizar um encoder para a senha
        entity.setSenha(dto.senha());
        return entity;
    }
}
