package br.edu.sgc;

/**
 * Ponto de entrada do Sistema de Gerenciamento de Construção.
 */
public class App {

    /**
     * Executa o sistema.
     *
     * @param args argumentos da linha de comando
     */
    public static void main(String[] args) {
        CalculadoraObra calculadora = new CalculadoraObra();

        double custo = calculadora.calcularCusto(100.0, 250.0);

        System.out.println("================================");
        System.out.println(" SGC - Construção");
        System.out.println("================================");
        System.out.printf("Área da obra: 100 m²%n");
        System.out.printf("Custo estimado: R$ %.2f%n", custo);
        System.out.println("Sistema executável criado pelo SGC.");
    }
}
