package io.github.isacgalvao.sistema.professor;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.github.isacgalvao.sistema.professor.dto.CreateProfessor;
import io.github.isacgalvao.sistema.professor.dto.UpdateProfessor;
import io.github.isacgalvao.sistema.professor.entities.Professor;
import io.github.isacgalvao.sistema.professor.entities.SituacaoProfessor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProfessorService {
    @Autowired
    private ProfessorRepository repository;

    public Professor save(CreateProfessor dto) {
        return repository.save(Professor.of(dto));
    }

    public Optional<Professor> findByUsuario(String usuario) {
        Optional<Professor> professor = findByUsuario(usuario);
        
        if (professor.isPresent() && professor.get().getSituacao() == SituacaoProfessor.ATIVO) {
            return professor;
        }

        log.warn("Professor não encontrado ou inativo.");
        return Optional.empty();
    }

    public Optional<Professor> findById(Long id) {
        Optional<Professor> professor = repository.findById(id);

        if (professor.isPresent() && professor.get().getSituacao() == SituacaoProfessor.ATIVO) {
            return professor;
        }

        log.warn("Professor não encontrado ou inativo.");
        return Optional.empty();
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }

    public Professor update(Long id, UpdateProfessor dto) {
        Optional<Professor> professor = repository.findById(id);

        if (professor.isPresent()) {
            return repository.save(professor.get().merge(dto));
        }

        throw new IllegalArgumentException("Professor não encontrado.");
    }

    public Iterable<Professor> findAll() {
        return repository.findAll();
    }

    public boolean existsById(Long id) {
        return repository.existsById(id);
    }

    public boolean existsByUsuario(String usuario) {
        return repository.existsByUsuario(usuario);
    }

    public boolean existsByEmail(String email) {
        return repository.existsByEmail(email);
    }
}
