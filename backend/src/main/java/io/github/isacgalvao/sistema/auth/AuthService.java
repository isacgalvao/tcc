package io.github.isacgalvao.sistema.auth;

import java.util.Optional;
import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import io.github.isacgalvao.sistema.aluno.AlunoRepository;
import io.github.isacgalvao.sistema.aluno.entities.Aluno;
import io.github.isacgalvao.sistema.professor.ProfessorRepository;
import io.github.isacgalvao.sistema.professor.entities.Professor;
import io.github.isacgalvao.sistema.utils.BCryptUtils;

@Service
public class AuthService {

    @Autowired
    private ProfessorRepository professorRepository;

    @Autowired
    private AlunoRepository alunoRepository;

    private final BCryptUtils bCrypt = BCryptUtils.getInstance();

    public Object login(String username, String email, String password) {
        CompletableFuture<Optional<Professor>> professor = CompletableFuture
                .supplyAsync(() -> professorRepository.findByUsuarioOrEmail(username, email));
        CompletableFuture<Optional<Aluno>> aluno = CompletableFuture
                .supplyAsync(() -> alunoRepository.findByUsuarioOrEmail(username, email));

        Optional<Professor> professorOpt = professor.join();
        if (professorOpt.isPresent()) {
            return bCrypt.verify(password, professorOpt.get().getSenha()) ? professorOpt.get() : null;
        }

        Optional<Aluno> alunoOpt = aluno.join();
        if (alunoOpt.isPresent()) {
            if (alunoOpt.get().getSenha() == null) {
                throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Senha não cadastrada. Entre em contato com o professor.");
            }
            return bCrypt.verify(password, alunoOpt.get().getSenha()) ? alunoOpt.get() : null;
        }

        throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
    }
}
