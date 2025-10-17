package edu.ucaldas.creational;

public class CreationalMain {
    public static void main(String[] args) {
        ShapeFactory factory = new ShapeFactory();
        Shape c = factory.createShape("Circle");
        Shape s = factory.createShape("Square");
        Shape unknown = factory.createShape("Triangle");

        System.out.println(c != null ? c.draw() : "null");
        System.out.println(s != null ? s.draw() : "null");
        System.out.println(unknown != null ? unknown.draw() : "No se reconoce el tipo");
    }
}
