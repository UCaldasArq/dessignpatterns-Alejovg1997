package edu.ucaldas.behavior;

public class ManagerHandler extends Handler {

    @Override
    public String handleRequest(String request) {
        if (request == null) return "No se puede atender la solicitud.";
        if (request.equalsIgnoreCase("avanzada") || request.equalsIgnoreCase("avanzado")) {
            return "Atendido por Gerente";
        } else if (next != null) {
            return next.handleRequest(request);
        }
        return "No se puede atender la solicitud.";
    }
}
