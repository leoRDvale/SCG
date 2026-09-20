package br.edu.sgc;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CalculadoraObraTest {

    private final CalculadoraObra calculadora = new CalculadoraObra();

    @Test
    void deveCalcularCustoDaObra() {
        assertEquals(25000.0, calculadora.calcularCusto(100, 250));
    }

    @Test
    void deveAceitarValoresZero() {
        assertEquals(0.0, calculadora.calcularCusto(0, 250));
    }

    @Test
    void deveRejeitarAreaNegativa() {
        assertThrows(
                IllegalArgumentException.class,
                () -> calculadora.calcularCusto(-1, 250)
        );
    }

    @Test
    void deveRejeitarCustoNegativo() {
        assertThrows(
                IllegalArgumentException.class,
                () -> calculadora.calcularCusto(100, -250)
        );
    }
}
