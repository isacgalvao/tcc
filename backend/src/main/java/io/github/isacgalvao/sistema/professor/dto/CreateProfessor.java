package io.github.isacgalvao.sistema.professor.dto;

import io.github.isacgalvao.sistema.professor.ProfessorConstraints;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;


public record CreateProfessor(
    @NotBlank(message = "não pode ser vazio.")
    @Size(max = ProfessorConstraints.Nome.MAX_SIZE, message = "deve conter no máximo {max} caracteres.")
    String nome,
    
    @NotBlank(message = "não pode ser vazio.")
    @Size(max = ProfessorConstraints.Email.MAX_SIZE, message = "deve conter no máximo {max} caracteres.")
    @Pattern(regexp = ProfessorConstraints.Email.PATTERN, message = ProfessorConstraints.Email.MESSAGE)
    String email,
    
    @NotBlank(message = "não pode ser vazio.")
    @Size(max = ProfessorConstraints.Usuario.MAX_SIZE, message = "deve conter no máximo {max} caracteres.")
    @Pattern(regexp = ProfessorConstraints.Usuario.PATTERN, message = ProfessorConstraints.Usuario.MESSAGE)
    String usuario,
    
    @NotBlank
    @Size(
        max = ProfessorConstraints.Password.MAX_SIZE,
        message = "deve conter no máximo {max} caracteres."
    )
    @Pattern(regexp = ProfessorConstraints.Password.PATTERN, message = ProfessorConstraints.Password.MESSAGE)
    String senha
) {}