package io.github.isacgalvao.sistema.aluno;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.github.isacgalvao.sistema.aluno.entities.Aluno;

@Service
public class AlunoService {
    @Autowired
    private AlunoRepository repository;

    public Optional<Aluno> findOneByIdOrUsername(Long id, String username) {
        return repository.findOneByIdOrUsername(id, username);
    }

    public Aluno save(Aluno aluno) {
        return repository.save(aluno);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }

    public boolean existsById(Long id) {
        return repository.existsById(id);
    }
}
