import java.util.List;

abstract class Shape {
    public abstract double getArea();
}

class Circle extends Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    public double getArea() {
        return Math.PI * radius * radius;
    }
}

class Rectangle extends Shape {
    private double width;
    private double height;

   
    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    @Override
    public double getArea() {
        return width * height; 
    }
}

public class ShapeAreaCalculator {

    public static double calculateTotalArea(List<? extends Shape> shapes) {
        double totalArea = 0.0;
        for (Shape shape : shapes) {
            totalArea += shape.getArea();
        }
        return totalArea;
    }


    public static void main(String[] args) {
        List<Shape> shapes = List.of(
            new Circle(5),        // Круг с радиусом 5
            new Rectangle(4, 6),  // Прямоугольник с шириной 4 и высотой 6
            new Circle(3)         // Круг с радиусом 3
        );

        double totalArea = calculateTotalArea(shapes);
        System.out.println("Total area of all shapes: " + totalArea);
    }
}
