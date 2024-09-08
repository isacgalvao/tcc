package io.github.isacgalvao.sistema.auth;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import io.github.isacgalvao.sistema.auth.dto.LoginDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@RestController
@RequestMapping("auth")
public class AuthController {

    @Autowired
    private AuthService service;

    @PostMapping("login")
    public Object login(@RequestBody LoginDTO dto) {
        if ((dto.user() == null || dto.user().isBlank()) && (dto.email() == null || dto.email().isBlank())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "É necessário informar o nome de usuário ou e-mail.");
        }

        String user = service.login(dto.user(), dto.email(), dto.password());
        if (user != null) {
            return user;
        }

        throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Usuário ou senha inválidos.");
    }
}
