import java.util.*;
import java.util.stream.Collectors;

public class Task10 {

    // Метод для знаходження міста з найвищою середньою температурою
    public static Optional<String> findCity(Map<String, List<Integer>> cityTemperatures) {
        return cityTemperatures.entrySet().stream()    // Створюємо потік з пар міст і списків температур
            .collect(Collectors.toMap(                 // Перетворюємо в нову мапу, де ключ — місто, значення — середня температура
                Map.Entry::getKey,                      // Ключ мапи — це місто
                entry -> entry.getValue().stream().mapToInt(Integer::intValue).average().orElse(Double.NaN) // Обчислюємо середню
            ))
            .entrySet().stream()                       // Перетворюємо мапу назад в потік для пошуку максимуму
            .max(Map.Entry.comparingByValue())         // Знаходимо місто з найвищою середньою температурою
            .map(Map.Entry::getKey);                   // Повертаємо тільки назву міста
    }

    public static void main(String[] args) {
        Map<String, List<Integer>> cityTemperatures = new HashMap<>();
        cityTemperatures.put("Kyiv", Arrays.asList(23, 25, 27, 22));
        cityTemperatures.put("Lviv", Arrays.asList(19, 20, 22, 21));
        cityTemperatures.put("Odessa", Arrays.asList(26, 28, 30, 29));
        cityTemperatures.put("Kharkiv", Arrays.asList(21, 23, 24, 22));

        // Виклик методу для знаходження міста з найвищою середньою температурою
        Optional<String> cityWithHighestTemp = findCity(cityTemperatures);

        // Виведення результату
        cityWithHighestTemp.ifPresentOrElse(
            city -> System.out.println("Місто з найвищою середньою температурою: " + city),
            () -> System.out.println("Немає даних про температури")
        );
    }
}
