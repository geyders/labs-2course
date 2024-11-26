import java.util.*;

public class UniqueElementsStorage {

    public static <T> Set<T> getUniqueElements(List<T> list) {
        return new HashSet<>(list); 
    }


    public static <T> Map<T, Integer> countOccurrences(List<T> list) {
        Map<T, Integer> occurrencesMap = new HashMap<>();

        for (T element : list) {
            occurrencesMap.put(element, occurrencesMap.getOrDefault(element, 0) + 1);
        }

        return occurrencesMap;
    }

    public static void main(String[] args) {
       
        List<String> list = Arrays.asList("apple", "banana", "apple", "orange", "banana", "apple");


        Set<String> uniqueElements = getUniqueElements(list);
        System.out.println("Unique elements: " + uniqueElements);

    
        Map<String, Integer> occurrences = countOccurrences(list);
        System.out.println("Occurrences count: " + occurrences);
    }
}
