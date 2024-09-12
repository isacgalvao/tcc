package io.github.isacgalvao.sistema.turmas.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import io.github.isacgalvao.sistema.turmas.entities.Presenca;

public interface PresencaRepository extends JpaRepository<Presenca, Long> {

    @Query("SELECT p FROM Presenca p WHERE p.turma.id = ?1")
    List<Presenca> buscarPresencasPorTurma(Long idTurma);
}
