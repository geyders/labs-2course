import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class Task5 {

    // Метод для обчислення добутку всіх непарних чисел у списку
    public static Optional<Integer> calculateOddProduct(List<Integer> numbers) {
        return numbers.stream()
            .filter(num -> num % 2 != 0)              // Фільтруємо непарні числа
            .reduce((a, b) -> a * b);                 // Обчислюємо добуток
    }

    public static void main(String[] args) {
        // Приклад списку цілих чисел
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

        // Виклик методу для обчислення добутку непарних чисел
        Optional<Integer> result = calculateOddProduct(numbers);

        // Виведення результату
        result.ifPresentOrElse(
            product -> System.out.println("Добуток непарних чисел: " + product),
            () -> System.out.println("Непарних чисел немає")
        );
    }
}
