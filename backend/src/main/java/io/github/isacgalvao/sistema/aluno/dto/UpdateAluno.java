package io.github.isacgalvao.sistema.aluno.dto;

import java.time.LocalDate;

import io.github.isacgalvao.sistema.aluno.entities.SituacaoAluno;
import jakarta.validation.constraints.Past;
import jakarta.validation.constraints.Pattern;

public record UpdateAluno(
    String nome,
    String email,
    @Pattern(regexp = "\\d{2}\\d{5}-\\d{4}")
    String telefone,
    @Past
    LocalDate dataNascimento,
    SituacaoAluno situacao,
    String usuario,
    String senha
) {}