package io.github.isacgalvao.sistema.aluno.dto;

import java.time.LocalDate;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;

public record CreateAluno(
    @NotNull
    @NotBlank
    String nome,
    
    @NotNull
    @NotBlank
    @Email
    String email,
    
    @NotNull
    @NotBlank
    @Past
    LocalDate dataNascimento
) {}
