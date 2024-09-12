package io.github.isacgalvao.sistema.turmas.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.validation.constraints.NotNull;

public record CreatePresenca(
    @NotNull
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    Date data,
    @NotNull
    Long alunoId,
    String justificativa
) {}
