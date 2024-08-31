package io.github.isacgalvao.sistema.professor;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import io.github.isacgalvao.sistema.professor.dto.CreateProfessor;
import io.github.isacgalvao.sistema.professor.dto.UpdateProfessor;
import io.github.isacgalvao.sistema.professor.entities.Professor;
import jakarta.validation.Valid;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("professores")
public class ProfessorController {
    
    @Autowired
    private ProfessorService service;

    @PostMapping(consumes = "application/json", produces = "application/json")
    @ResponseStatus(HttpStatus.CREATED)
    public Professor criar(@RequestBody @Valid CreateProfessor dto) {
        if (service.existsByUsuario(dto.usuario())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Usuário já cadastrado.");
        }
        
        if (service.existsByEmail(dto.email())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Email já cadastrado.");
        }

        return service.save(dto);
    }

    @GetMapping("{id}")
    public Professor buscaProfessor(@PathVariable Long id) {
        Optional<Professor> professor = service.findById(id);

        if (professor.isPresent()) {
            return professor.get();
        }

        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Professor não encontrado.");
    }    

    // NOTE - Talvez seja interessante criar endpoints especificos para atualizar usuario e email
    @PutMapping(value = "{id}", consumes = "application/json")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void atualizar(@PathVariable Long id, @RequestBody @Valid UpdateProfessor dto) {
        if (service.existsByUsuario(dto.usuario())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Usuário já cadastrado.");
        }

        if (service.existsByEmail(dto.email())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Email já cadastrado.");
        }

        try {
            service.update(id, dto);
        } catch (IllegalArgumentException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deletar(@PathVariable Long id) {
        if (!service.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Não é possível deletar um professor que não existe.");
        }
        service.deleteById(id);
    }
}
