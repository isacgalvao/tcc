package io.github.isacgalvao.sistema.turmas.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.github.isacgalvao.sistema.turmas.entities.Presenca;
import io.github.isacgalvao.sistema.turmas.repositories.PresencaRepository;

@Service
public class PresencaService {

    @Autowired
    private PresencaRepository repository;

    public List<Presenca> buscarPresencasPorTurma(Long idTurma) {
        return repository.buscarPresencasPorTurma(idTurma);
    }

    public List<Presenca> saveMany(List<Presenca> presencas) {
        return repository.saveAll(presencas);
    }

    public Presenca salvar(Presenca entity) {
        return repository.save(entity);
    }

    public void remover(Long presencaId) {
        repository.deleteById(presencaId);
    }

    public Optional<Presenca> buscarPorId(Long presencaId) {
        return repository.findById(presencaId);
    }

    public boolean existsById(Long presencaId) {
        return repository.existsById(presencaId);
    }
}
