package io.github.isacgalvao.sistema.aluno;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("alunos")
public class AlunoController {
    @Autowired
    private AlunoService service;
}
