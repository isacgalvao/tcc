package io.github.isacgalvao.sistema.turmas.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import io.github.isacgalvao.sistema.turmas.entities.Avaliacao;

public interface AvaliacaoRepository extends JpaRepository<Avaliacao, Long> {
    
    @Query("SELECT a FROM Avaliacao a WHERE a.turma.id = ?1")
    List<Avaliacao> findByTurmaId(Long turmaId);
}
