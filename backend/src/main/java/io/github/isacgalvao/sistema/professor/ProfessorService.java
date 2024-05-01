package io.github.isacgalvao.sistema.professor;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.github.isacgalvao.sistema.professor.dto.CreateProfessor;
import io.github.isacgalvao.sistema.professor.dto.UpdateProfessor;
import io.github.isacgalvao.sistema.professor.entities.Professor;

@Service
public class ProfessorService {
    @Autowired
    private ProfessorRepository repository;

    public Professor save(CreateProfessor dto) {
        return repository.save(Professor.of(dto));
    }

    public Professor findByUsuario(String usuario) {
        return repository.findByUsuario(usuario);
    }

    public Optional<Professor> findById(Long id) {
        return repository.findById(id);
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
