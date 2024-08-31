package io.github.isacgalvao.sistema.turmas;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("turmas")
public class TurmaController {
    @GetMapping
    public String listarTurmas() {
        return "Listando turmas";
    }
}
