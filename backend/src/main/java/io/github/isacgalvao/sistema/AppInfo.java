package io.github.isacgalvao.sistema;

import org.springframework.web.bind.annotation.RestController;
import io.github.isacgalvao.sistema.utils.DateUtils;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
public class AppInfo {
    @GetMapping("healthcheck")
    public String healthcheck() {
        return "UP";
    }

    @GetMapping("datetime")
    public String datetime() {
        return DateUtils.now();
    }
}