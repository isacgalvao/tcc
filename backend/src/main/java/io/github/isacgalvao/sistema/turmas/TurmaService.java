package io.github.isacgalvao.sistema.turmas;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.github.isacgalvao.sistema.turmas.entities.Turma;

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

    public void update(Long id, Turma turma) {
        repository.save(turma);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
