import java.util.*;
import java.util.stream.Collectors;

public class Task9 {

    // Метод для отримання списку назв продуктів у верхньому регістрі з непорожніх Optionals
    public static List<String> getProductNames(Map<Integer, Optional<String>> productMap) {
        return productMap.values().stream()              // Створюємо потік з значень Map (Optional<String>)
            .filter(Optional::isPresent)                // Фільтруємо тільки непорожні Optional
            .map(Optional::get)                         // Отримуємо значення з Optional
            .map(String::toUpperCase)                   // Перетворюємо назви в верхній регістр
            .collect(Collectors.toList());              // Збираємо результат у список
    }

    public static void main(String[] args) {
        Map<Integer, Optional<String>> productMap = new HashMap<>();
        productMap.put(1, Optional.of("Laptop"));
        productMap.put(2, Optional.empty());
        productMap.put(3, Optional.of("Phone"));
        productMap.put(4, Optional.of("Tablet"));
        productMap.put(5, Optional.empty());

        // Виклик методу для отримання назв продуктів у верхньому регістрі
        List<String> productNames = getProductNames(productMap);

        // Виведення результату
        System.out.println("Назви продуктів у верхньому регістрі: " + productNames);
    }
}
