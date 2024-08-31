package io.github.isacgalvao.sistema.professor;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import io.github.isacgalvao.sistema.professor.entities.Professor;

public interface ProfessorRepository extends JpaRepository<Professor, Long>{
    @Query("SELECT p FROM Professor p WHERE p.usuario = ?1")
    public Optional<Professor> findByUsuario(String usuario);

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN TRUE ELSE FALSE END FROM Professor p WHERE p.usuario = ?1")
    public boolean existsByUsuario(String usuario);

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN TRUE ELSE FALSE END FROM Professor p WHERE p.email = ?1")
    public boolean existsByEmail(String email);
}
