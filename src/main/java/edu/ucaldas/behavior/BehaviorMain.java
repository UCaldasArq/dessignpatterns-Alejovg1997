package edu.ucaldas.behavior;

public class BehaviorMain {
    public static void main(String[] args) {
        Handler handler = SupportHandler.createChain();

        System.out.println(handler.handleRequest("básica"));
        System.out.println(handler.handleRequest("intermedia"));
        System.out.println(handler.handleRequest("avanzada"));
        System.out.println(handler.handleRequest("desconocida"));
    }
}
