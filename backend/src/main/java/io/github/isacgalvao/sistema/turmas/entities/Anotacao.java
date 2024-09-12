package io.github.isacgalvao.sistema.turmas.entities;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.github.isacgalvao.sistema.turmas.dto.CreateAnotacao;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "anotacoes")
@Data
public class Anotacao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Date data;

    @Column
    private String conteudo;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "turma_id")
    private Turma turma;

    public static Anotacao of(Long idTurma, CreateAnotacao dto) {
        Anotacao anotacao = new Anotacao();
        anotacao.setConteudo(dto.conteudo());
        anotacao.setData(new Date());
        anotacao.setTurma(Turma.of(idTurma));
        return anotacao;
    }

    public Anotacao merge(CreateAnotacao dto) {
        if (dto.conteudo() != null) {
            this.conteudo = dto.conteudo();
        }
        return this;
    }
}
