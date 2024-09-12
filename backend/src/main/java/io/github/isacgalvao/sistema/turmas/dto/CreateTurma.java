package io.github.isacgalvao.sistema.turmas.dto;

import java.util.List;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;

public record CreateTurma(
    @NotBlank
    String nome,
    @NotBlank
    String disciplina,
    @NotNull
    @NotEmpty
    List<Long> alunos,
    @NotNull
    @PositiveOrZero
    Double notaMinima
) {}
