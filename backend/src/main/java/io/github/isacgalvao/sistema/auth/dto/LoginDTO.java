package io.github.isacgalvao.sistema.auth.dto;

public record LoginDTO(
    String user,
    String email,
    String password
) {}
