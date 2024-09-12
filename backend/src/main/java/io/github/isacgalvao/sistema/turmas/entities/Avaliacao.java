package io.github.isacgalvao.sistema.turmas.entities;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.github.isacgalvao.sistema.turmas.dto.CreateAvaliacao;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "avaliacoes")
@Data
public class Avaliacao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private Date data;

    @OneToMany(mappedBy = "avaliacao", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Nota> notas = new ArrayList<>();

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "turma_id")
    private Turma turma;

    public static Avaliacao of(Long turmaId, CreateAvaliacao dto) {
        Avaliacao avaliacao = new Avaliacao();
        avaliacao.setData(dto.data());
        avaliacao.setTurma(Turma.of(turmaId));
        avaliacao.setNotas(dto.notas().stream().map(n -> {
            Nota nota = Nota.of(n);
            nota.setAvaliacao(avaliacao);
            return nota;
        }).toList());
        return avaliacao;
    }

    public Avaliacao merge(CreateAvaliacao dto) {
        if (dto.data() != null) {
            setData(dto.data());
        }

        if (dto.notas() != null && !dto.notas().isEmpty()) {
            getNotas().clear();
            for (var notaDto : dto.notas()) {
                Nota nota = Nota.of(notaDto);
                nota.setAvaliacao(this);
                notas.add(nota);
            }
        }

        return this;
    }
}
