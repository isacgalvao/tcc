package io.github.isacgalvao.sistema.turmas.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import io.github.isacgalvao.sistema.turmas.entities.Turma;

public interface TurmasRepository extends JpaRepository<Turma, Long> {

    @Query("SELECT t FROM Turma t WHERE t.professor.id = ?1")
    List<Turma> findByProfessorId(Long professorId);
}
