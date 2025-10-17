package edu.ucaldas.behavior;

public class BasicSupportHandler extends Handler {

    @Override
    public String handleRequest(String request) {
        if (request == null) return "No se puede atender la solicitud.";
        if (request.equalsIgnoreCase("básica") || request.equalsIgnoreCase("basica")) {
            return "Atendido por Soporte Básico";
        } else if (next != null) {
            return next.handleRequest(request);
        }
        return "No se puede atender la solicitud.";
    }
}
