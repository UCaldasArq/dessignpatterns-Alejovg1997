package edu.ucaldas.structural;

public class StructuralMain {
    public static void main(String[] args) {
        Notifier email = new EmailNotifier();
        System.out.println(email.send("Hola"));

        Notifier sms = new SMSNotifier(email);
        System.out.println(sms.send("Hola"));
    }
}
