package io.github.isacgalvao.sistema;

import java.util.HashMap;
import java.util.Map;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import com.fasterxml.jackson.databind.exc.InvalidFormatException;

@RestControllerAdvice
public class GlobalExceptionHandler {
    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler(NoResourceFoundException.class)
    public ResponseEntity<Object> handleError404(NoResourceFoundException ex) {
        Map<String, Object> errorAttributes = Map.of(
            "message", "Path not found",
            "status", HttpStatus.NOT_FOUND.value(),
            "error", HttpStatus.NOT_FOUND.getReasonPhrase(),
            "path", "/" + ex.getResourcePath()
        );
        return new ResponseEntity<>(errorAttributes, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, Object> handleValidationException(MethodArgumentNotValidException e) {
        Map<String, Object> erros = new HashMap<>();

        e.getBindingResult().getAllErrors().forEach(error -> {
            String campo = ((FieldError) error).getField();
            String mensagem = error.getDefaultMessage();
            erros.put(campo, mensagem);
        });

        return erros;
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, Object> handleNoBodyException(HttpMessageNotReadableException e) {
        if (e.getCause() != null) {
            if (e.getCause().getClass() == InvalidFormatException.class) {
                InvalidFormatException cause = (InvalidFormatException) e.getCause();
                return Map.of("message", "Campo " + cause.getPath().get(0).getFieldName() + " com valor invalido.");
            }
        }
        return Map.of("message", "O corpo da requisicao nao pode ser vazio.");
    }

    @ExceptionHandler(DataIntegrityViolationException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, Object> handleDataIntegrityViolationException(DataIntegrityViolationException e) {
        if (e.getMessage().contains("violates foreign key constraint")) {
            return Map.of("message", "Registro nao pode ser excluido pois esta sendo utilizado em outra tabela.");
        }

        if (e.getMessage().contains("violates unique constraint")) {
            return Map.of("message", "Registro duplicado.");
        }

        return Map.of("message", "Erro de integridade de dados.");
    }

    @ExceptionHandler(ResponseStatusException.class)
    public ResponseEntity<Map<String, Object>> handleResponseStatusException(ResponseStatusException e) {
        return ResponseEntity.status(e.getStatusCode()).body(Map.of("message", e.getReason()));
    }
}
