package edu.ucaldas.structural;

public class SMSNotifier extends NotifierDecorator {
    public SMSNotifier(Notifier wrappee) {
        super(wrappee);
    }

    @Override
    public String send(String message) {
        String emailResult = super.send(message);
        return "SMS enviado: " + message + " | " + emailResult;
    }
}
