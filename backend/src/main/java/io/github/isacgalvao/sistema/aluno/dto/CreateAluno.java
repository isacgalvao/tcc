package io.github.isacgalvao.sistema.aluno.dto;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;

public record CreateAluno(
    @NotBlank
    String nome,
    
    @Email
    String email,

    @Pattern(regexp = "\\d{2,3}\\d{4,5}\\d{4}", message = "inválido")
    String telefone,
    
    @NotNull
    @Past
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy")
    LocalDate dataNascimento,
    
    @NotNull
    @Positive
    Long professorId
) {}
