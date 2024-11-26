import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class Task2 {
    public static List<Integer> processOptionals(List<Optional<Integer>> optionals) {
        return optionals.stream() //перетворюємо список в потік (стрим)
            .filter(Optional::isPresent)   // Фільтруємо лише непорожні Optional
            .map(Optional::get)            // Отримуємо значення з Optional
            .collect(Collectors.toList()); // Збираємо в список
    }

    public static void main(String[] args) {
        List<Optional<Integer>> optionals = Arrays.asList(
            Optional.of(1),
            Optional.empty(),
            Optional.of(3),
            Optional.empty(),
            Optional.of(5)
        );

        List<Integer> result = processOptionals(optionals); //обробка списку
        System.out.println("Результат: " + result);
    }
}
