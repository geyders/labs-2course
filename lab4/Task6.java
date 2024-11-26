import java.util.*;
import java.util.stream.Collectors;

class Person {
    private String name;
    private List<Person> friends;

    public Person(String name, List<Person> friends) {
        this.name = name;
        this.friends = friends;
    }

    public String getName() {
        return name;
    }

    public List<Person> getFriends() {
        return friends;
    }
}

public class Task6 {

    // Метод для отримання унікальних імен друзів у верхньому регістрі
    public static List<String> getUniqueUppercase(List<Person> persons) {
        return persons.stream()
            .flatMap(person -> person.getFriends().stream())  // Розгортаємо списки друзів у один потік
            .map(friend -> friend.getName().toUpperCase())    // Перетворюємо імена в верхній регістр
            .distinct()                                       // Фільтруємо унікальні імена
            .collect(Collectors.toList());                    // Збираємо результат у список
    }

    public static void main(String[] args) {
        Person john = new Person("John", new ArrayList<>());
        Person jane = new Person("Jane", Arrays.asList(john));
        Person emily = new Person("Emily", Arrays.asList(john, jane));
        Person anna = new Person("Anna", Arrays.asList(jane, emily));

        List<Person> persons = Arrays.asList(john, jane, emily, anna);

        // Виклик методу для отримання унікальних імен друзів у верхньому регістрі
        List<String> uniqueFriendsNames = getUniqueUppercase(persons);

        // Виведення результату
        System.out.println("Унікальні імена друзів у верхньому регістрі: " + uniqueFriendsNames);
    }
}
