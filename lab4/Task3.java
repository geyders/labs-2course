import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

public class Task3 {

    public static Optional<String> findLongestName(List<String> names) {
        return names.stream()
            .max(Comparator.comparingInt(String::length)); 
    }

    public static void main(String[] args) {

        List<String> names = Arrays.asList("Anna", "Maximilian", "Olga", "Alexander");

        Optional<String> longestName = findLongestName(names);

        longestName.ifPresentOrElse(
            name -> System.out.println("Найдовше ім'я: " + name),
            () -> System.out.println("Список порожній")
        );
    }
}
