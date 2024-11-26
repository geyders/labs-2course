import java.util.*;

class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    @Override
    public String toString() {
        return "Product{name='" + name + "', price=" + price + '}';
    }
}

public class Task8 {

    // Метод для пошуку другого найдорожчого продукту
    public static Optional<String> findSecMostExpProduct(List<Product> products) {
        return products.stream()
            .sorted(Comparator.comparingDouble(Product::getPrice).reversed()) // Сортуємо за спаданням ціни
            .skip(1)                                                          // Пропускаємо найдорожчий продукт
            .findFirst()                                                       // Знаходимо другий продукт
            .map(Product::getName);                                            // Отримуємо назву продукту
    }

    public static void main(String[] args) {
        List<Product> products = Arrays.asList(
            new Product("Laptop", 1500.0),
            new Product("Phone", 800.0),
            new Product("Monitor", 500.0),
            new Product("Tablet", 600.0)
        );

        // Виклик методу для пошуку другого найдорожчого продукту
        Optional<String> secMostExpProduct = findSecMostExpProduct(products);

        // Виведення результату
        secMostExpProduct.ifPresentOrElse(
            name -> System.out.println("Другий найдорожчий продукт: " + name),
            () -> System.out.println("Другий найдорожчий продукт не знайдено")
        );
    }
}
