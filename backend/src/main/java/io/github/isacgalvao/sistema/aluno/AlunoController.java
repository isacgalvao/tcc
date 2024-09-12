package io.github.isacgalvao.sistema.aluno;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import io.github.isacgalvao.sistema.aluno.dto.CreateAluno;
import io.github.isacgalvao.sistema.aluno.dto.UpdateAluno;
import io.github.isacgalvao.sistema.aluno.entities.Aluno;
import io.github.isacgalvao.sistema.professor.ProfessorService;
import jakarta.validation.Valid;

@RestController
@RequestMapping("alunos")
public class AlunoController {
    @Autowired
    private AlunoService service;

    @Autowired
    private ProfessorService professorService;

    @GetMapping("{idOrUsername}")
    public Aluno findOne(@PathVariable String idOrUsername) {
        if (idOrUsername.matches("\\d+")) {
            Optional<Aluno> alunoOpt = service.findOneByIdOrUsername(Long.parseLong(idOrUsername), null);
            if (alunoOpt.isPresent()) {
                return alunoOpt.get();
            } else {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Aluno não encontrado");
            }
        } else {
            Optional<Aluno> alunoOpt = service.findOneByIdOrUsername(null, idOrUsername);
            if (alunoOpt.isPresent()) {
                return alunoOpt.get();
            } else {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Aluno não encontrado");
            }
        }
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Object save(@RequestBody @Valid CreateAluno dto) {
        if (professorService.existsById(dto.professorId())) {
            return Map.of("id", service.save(Aluno.of(dto)).getId());
        }
        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Professor não encontrado");
    }

    @PutMapping("{idOrUsername}")
    public void update(@PathVariable String idOrUsername, @RequestBody @Valid UpdateAluno dto) {
        if (idOrUsername.matches("\\d+")) {
            Optional<Aluno> alunoOpt = service.findOneByIdOrUsername(Long.parseLong(idOrUsername), null);
            if (alunoOpt.isPresent()) {
                service.save(alunoOpt.get().merge(dto));
            } else {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Aluno não encontrado");
            }
        } else {
            Optional<Aluno> alunoOpt = service.findOneByIdOrUsername(null, idOrUsername);
            if (alunoOpt.isPresent()) {
                service.save(alunoOpt.get().merge(dto));
            } else {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Aluno não encontrado");
            }
        }
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id) {
        if (service.existsById(id)) {
            service.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Aluno não encontrado");
        }        
    }
}
