import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class Task1 {
    public static void main(String[] args) {
        List<String> strings = Arrays.asList("Apple", "Xenon", "Xylophone", "Example", "X-factor", "Xylem");

        // Пошук першого відповідного елемента
        Optional<String> result = strings.stream()
            .filter(s -> s.startsWith("X"))  // Фільтруємо рядки, що починаються з "X"
            .filter(s -> s.length() > 5)     // Залишаємо рядки з довжиною більше 5 символів
            .findFirst();                    // Знаходимо перший відповідний елемент

        String finalResult = result.orElse("Default");

        System.out.println("Result: " + finalResult);
    }
}
