import java.util.ArrayList;
import java.util.List;

public class LowerBoundedWildcard {

    public static void addToList(List<? super Integer> list) {
        for (int i = 1; i <= 10; i++) {
            list.add(i); 
        }
    }

    public static void main(String[] args) {
        List<Integer> integerList = new ArrayList<>();
        addToList(integerList); 
        System.out.println("List<Integer> после добавления: " + integerList);

        List<Number> numberList = new ArrayList<>();
        addToList(numberList); 
        System.out.println("List<Number> после добавления: " + numberList);

        List<Object> objectList = new ArrayList<>();
        addToList(objectList); 
        System.out.println("List<Object> после добавления: " + objectList);
    }
}
