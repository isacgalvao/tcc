package io.github.isacgalvao.sistema.turmas.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.github.isacgalvao.sistema.turmas.entities.SituacaoTurma;
import io.github.isacgalvao.sistema.turmas.entities.Turma;
import io.github.isacgalvao.sistema.turmas.repositories.TurmasRepository;

@Service
public class TurmaService {
    @Autowired
    private TurmasRepository repository;

    public Turma salvar(Turma turma) {
        return repository.save(turma);
    }

    public Turma buscarPorId(Long id) {
        Optional<Turma> turma = repository.findById(id);

        if (turma.isPresent()) {
            return turma.get();
        }

        throw new IllegalArgumentException("Turma não encontrada");
    }

    public void remover(Long id) {
        repository.deleteById(id);
    }

    // professor
    public List<Turma> buscarPorProfessor(Long professorId) {
        return repository.findByProfessorId(professorId);
    }

    public boolean existsById(Long id) {
        return repository.existsById(id);
    }

    public void consolidar(Long turmaId) {
        Turma turma = buscarPorId(turmaId);
        if (turma.getSituacao() == SituacaoTurma.CONCLUIDA) {
            throw new IllegalArgumentException("Turma já consolidada");
        }
        turma.consolidar();
        salvar(turma);
    }
}
