package edu.ucaldas.behavior;

public class SupervisorHandler extends Handler {

    @Override
    public String handleRequest(String request) {
        if (request == null) return "No se puede atender la solicitud.";
        if (request.equalsIgnoreCase("intermedia") || request.equalsIgnoreCase("intermedio")) {
            return "Atendido por Supervisor";
        } else if (next != null) {
            return next.handleRequest(request);
        }
        return "No se puede atender la solicitud.";
    }
}
