package io.github.isacgalvao.sistema.turmas;

import java.util.List;
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

import io.github.isacgalvao.sistema.aluno.AlunoService;
import io.github.isacgalvao.sistema.aluno.entities.Aluno;
import io.github.isacgalvao.sistema.turmas.dto.CreateAnotacao;
import io.github.isacgalvao.sistema.turmas.dto.CreateAvaliacao;
import io.github.isacgalvao.sistema.turmas.dto.CreatePresenca;
import io.github.isacgalvao.sistema.turmas.dto.CreateTurma;
import io.github.isacgalvao.sistema.turmas.dto.UpdateTurma;
import io.github.isacgalvao.sistema.turmas.entities.Anotacao;
import io.github.isacgalvao.sistema.turmas.entities.Avaliacao;
import io.github.isacgalvao.sistema.turmas.entities.Presenca;
import io.github.isacgalvao.sistema.turmas.entities.Turma;
import io.github.isacgalvao.sistema.turmas.services.AnotacaoService;
import io.github.isacgalvao.sistema.turmas.services.AvaliacaoService;
import io.github.isacgalvao.sistema.turmas.services.PresencaService;
import io.github.isacgalvao.sistema.turmas.services.TurmaService;
import jakarta.validation.Valid;

@RestController
@RequestMapping("professor/{professorId}/turmas")
public class TurmaController {
    @Autowired
    private TurmaService service;

    @Autowired
    private PresencaService presencaService;

    @Autowired
    private AnotacaoService anotacaoService;

    @Autowired
    private AvaliacaoService avaliacaoService;

    @Autowired
    private AlunoService alunoService;

    @GetMapping
    public List<Turma> buscarTurmas(@PathVariable Long professorId) {
        return service.buscarPorProfessor(professorId);
    }

    @GetMapping("{turmaId}")
    public Turma buscarTurma(@PathVariable Long professorId, @PathVariable Long turmaId) {
        return service.buscarPorId(turmaId);
    }

    @PostMapping
    public Object criarTurma(@PathVariable Long professorId, @RequestBody @Valid CreateTurma dto) {
        return Map.of("id", service.salvar(Turma.of(professorId, dto)).getId());
    }

    @PutMapping("{turmaId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void atualizarTurma(@PathVariable Long professorId, @PathVariable Long turmaId, @RequestBody UpdateTurma dto) {
        service.salvar(service.buscarPorId(turmaId).merge(dto));
    }

    @PutMapping("{turmaId}/alunos/{alunoId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void adicionarAluno(@PathVariable Long professorId, @PathVariable Long turmaId, @PathVariable Long alunoId) {
        Turma turma = service.buscarPorId(turmaId);
        if (alunoService.existsById(alunoId)) {
            turma.adicionarAlunos(alunoId);
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Aluno não existe");
        }
        service.salvar(turma);
    }

    // PRESENCA
    @GetMapping("{turmaId}/presencas")
    public List<Presenca> presencas(@PathVariable Long professorId, @PathVariable Long turmaId) {
        return presencaService.buscarPresencasPorTurma(turmaId);
    }

    @GetMapping("{turmaId}/presencas/{presencaId}")
    public Presenca buscarPresencaPorId(@PathVariable Long professorId, @PathVariable Long turmaId, @PathVariable Long presencaId) {
        Optional<Presenca> presencaOpt = presencaService.buscarPorId(presencaId);

        if (presencaOpt.isPresent()) {
            return presencaOpt.get();
        }

        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Presenca nao encontrada");
    }

    @PostMapping("{turmaId}/presencas")
    @ResponseStatus(HttpStatus.CREATED)
    public void adicionarPresenca(@PathVariable Long professorId, @PathVariable Long turmaId, @RequestBody @Valid List<CreatePresenca> dto) {
        presencaService.saveMany(dto.stream().map(p -> Presenca.of(turmaId, p)).toList());
    }

    @DeleteMapping("{turmaId}/presencas/{presencaId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removerPresenca(@PathVariable Long professorId, @PathVariable Long turmaId, @PathVariable Long presencaId) {
        if (presencaService.existsById(presencaId)) {
            presencaService.remover(presencaId);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Presenca nao encontrada");
        }
    }

    // ANOTACOES
    @GetMapping("{turmaId}/anotacoes")
    public List<Anotacao> anotacoes(@PathVariable Long professorId, @PathVariable Long turmaId) {
        return anotacaoService.buscarPorTurma(turmaId);
    }
    
    @GetMapping("{turmaId}/anotacoes/{anotacaoId}")
    public Anotacao buscarAnotacaoPorId(@PathVariable Long professorId, @PathVariable Long turmaId, @PathVariable Long anotacaoId) {
        Optional<Anotacao> anotacaoOpt = anotacaoService.buscarPorId(anotacaoId);
        
        if(anotacaoOpt.isPresent()) {
            return anotacaoOpt.get();
        }

        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Anotacao nao encontrada");
    }

    @PostMapping("{turmaId}/anotacoes")
    @ResponseStatus(HttpStatus.CREATED)
    public void criarAnotacao(@PathVariable Long professorId, @PathVariable Long turmaId, @RequestBody CreateAnotacao dto) {
        anotacaoService.salvar(Anotacao.of(turmaId, dto));
    }

    @PutMapping("{turmaId}/anotacoes/{anotacaoId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void atualizarAnotacao(@PathVariable Long professorId, @PathVariable Long turmaId, @PathVariable Long anotacaoId, @RequestBody CreateAnotacao dto) {
        Optional<Anotacao> anotacaoOpt = anotacaoService.buscarPorId(anotacaoId);
        
        if (anotacaoOpt.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Anotacao nao encontrada");
        }

        anotacaoService.salvar(anotacaoOpt.get().merge(dto));
    }

    @DeleteMapping("{turmaId}/anotacoes/{anotacaoId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removerAnotacao(@PathVariable Long professorId, @PathVariable Long turmaId, @PathVariable Long anotacaoId) {
        if (anotacaoService.existsById(anotacaoId)) {
            anotacaoService.remover(anotacaoId);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Anotacao nao encontrada");
        }
    }

    // AVALICAOES
    @GetMapping("{turmaId}/avaliacoes")
    public List<Avaliacao> avaliacoes(@PathVariable Long professorId, @PathVariable Long turmaId) {
        return avaliacaoService.buscarPorTurma(turmaId);
    }

    @GetMapping("{turmaId}/avaliacoes/{avaliacaoId}")
    public Avaliacao buscarAvaliacaoPorId(@PathVariable Long professorId, @PathVariable Long turmaId, @PathVariable Long avaliacaoId) {
        Optional<Avaliacao> avaliacaoOpt = avaliacaoService.buscarPorId(avaliacaoId);

        if (avaliacaoOpt.isPresent()) {
            return avaliacaoOpt.get();
        }

        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Avaliacao nao encontrada");
    }

    @PostMapping("{turmaId}/avaliacoes")
    @ResponseStatus(HttpStatus.CREATED)
    public void criarAvaliacao(@PathVariable Long professorId, @PathVariable Long turmaId, @RequestBody CreateAvaliacao avaliacao) {
        avaliacaoService.salvar(Avaliacao.of(turmaId, avaliacao));
    }

    @DeleteMapping("{turmaId}/avaliacoes/{avaliacaoId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removerAvaliacao(@PathVariable Long professorId, @PathVariable Long turmaId, @PathVariable Long avaliacaoId) {
        if (avaliacaoService.existsById(avaliacaoId)) {
            avaliacaoService.remover(avaliacaoId);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Avaliacao nao encontrada");
        }
    }

    @PutMapping("{turmaId}/avaliacoes/{avaliacaoId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void atualizarAvaliacao(@PathVariable Long professorId, @PathVariable Long turmaId, @PathVariable Long avaliacaoId, @RequestBody CreateAvaliacao dto) {
        Optional<Avaliacao> avaliacaoOpt = avaliacaoService.buscarPorId(avaliacaoId);

        if (avaliacaoOpt.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Avaliacao nao encontrada");
        }

        avaliacaoService.salvar(avaliacaoOpt.get().merge(dto));
    }

    // alunos
    @GetMapping("{turmaId}/alunos")
    public List<Aluno> buscarAlunos(@PathVariable Long professorId, @PathVariable Long turmaId) {
        return service.buscarPorId(turmaId).getAlunos();
    }

    @PostMapping("{turmaId}/consolidar")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void consolidarTurma(@PathVariable Long professorId, @PathVariable Long turmaId) {
        if (service.existsById(turmaId)) {
            try {
                service.consolidar(turmaId);
            } catch (IllegalArgumentException e) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage());
            }
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Turma nao encontrada");
        }
    }

    @DeleteMapping("{turmaId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removerTurma(@PathVariable Long professorId, @PathVariable Long turmaId) {
        if (service.existsById(turmaId)) {
            service.remover(turmaId);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Turma nao encontrada");
        }
    }
}
