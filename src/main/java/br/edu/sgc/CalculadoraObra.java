package br.edu.sgc;

/**
 * Realiza cálculos básicos relacionados a uma obra.
 */
public class CalculadoraObra {

    /**
     * Calcula o custo estimado de uma obra.
     *
     * @param area área da obra em metros quadrados
     * @param custoPorMetro custo estimado por metro quadrado
     * @return custo total estimado
     */
    public double calcularCusto(double area, double custoPorMetro) {
        if (area < 0 || custoPorMetro < 0) {
            throw new IllegalArgumentException("Área e custo não podem ser negativos.");
        }

        return area * custoPorMetro;
    }
}
