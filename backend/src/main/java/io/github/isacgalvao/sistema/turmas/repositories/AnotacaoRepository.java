package io.github.isacgalvao.sistema.turmas.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import io.github.isacgalvao.sistema.turmas.entities.Anotacao;

public interface AnotacaoRepository extends JpaRepository<Anotacao, Long> {
    
    @Query("SELECT a FROM Anotacao a WHERE a.turma.id = ?1")
    List<Anotacao> buscarPorTurma(Long turmaId);
}
