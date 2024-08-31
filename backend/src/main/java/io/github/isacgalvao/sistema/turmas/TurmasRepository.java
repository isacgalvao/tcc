package io.github.isacgalvao.sistema.turmas;

import org.springframework.data.jpa.repository.JpaRepository;

import io.github.isacgalvao.sistema.turmas.entities.Turma;

public interface TurmasRepository extends JpaRepository<Turma, Long> {}
