package edu.ucaldas.creational;

// TODO: Implementa el patrón Factory Method.
// Crea un método createShape(String type) que devuelva:
// "Circle" → new Circle()
// "Square" → new Square()
// Si el tipo no existe, retorna null.

public class ShapeFactory {
    public Shape createShape(String type) {
        if (type == null) return null;
        switch (type) {
            case "Circle":
                return new Circle();
            case "Square":
                return new Square();
            default:
                return null;
        }
    }
}

class Circle implements Shape {
    @Override
    public String draw() {
        return "Dibujando un círculo.";
    }
}

class Square implements Shape {
    @Override
    public String draw() {
        return "Dibujando un cuadrado.";
    }
}
