package io.github.isacgalvao.sistema.turmas.dto;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

public record CreateAvaliacao(
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy")
    Date data,
    List<CreateNota> notas
) {}
