package io.github.isacgalvao.sistema.turmas.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.github.isacgalvao.sistema.turmas.entities.Anotacao;
import io.github.isacgalvao.sistema.turmas.repositories.AnotacaoRepository;

@Service
public class AnotacaoService {
    @Autowired
    private AnotacaoRepository repository;

    public List<Anotacao> buscarPorTurma(Long turmaId) {
        return repository.buscarPorTurma(turmaId);
    }

    public Optional<Anotacao> buscarPorId(Long anotacaoId) {
        return repository.findById(anotacaoId);
    }

    public Anotacao salvar(Anotacao entity) {
        return repository.save(entity);
    }

    public void remover(Long anotacaoId) {
        repository.deleteById(anotacaoId);
    }

    public boolean existsById(Long anotacaoId) {
        return repository.existsById(anotacaoId);
    }
}
