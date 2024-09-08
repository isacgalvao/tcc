package io.github.isacgalvao.sistema.aluno;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import io.github.isacgalvao.sistema.aluno.entities.Aluno;

public interface AlunoRepository extends JpaRepository <Aluno, Long> {
    @Query("SELECT a FROM Aluno a WHERE a.usuario = ?1 OR a.email = ?2")
    Optional<Aluno> findByUsuarioOrEmail(String usuario, String email);

    @Query("SELECT a FROM Aluno a WHERE a.email = :email")
    Optional<Aluno> findByEmail(String email);
}
