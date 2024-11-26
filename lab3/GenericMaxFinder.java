public class GenericMaxFinder {

    public static <T extends Comparable<T>> T findMax(T[] array) {
        if (array == null || array.length == 0) {
            throw new IllegalArgumentException("Array is empty or null");
        }

        T max = array[0]; 
        for (T element : array) {
            if (element.compareTo(max) > 0) { 
                max = element;
            }
        }
        return max;
    }

    
    public static void main(String[] args) {
        Integer[] intArray = {3, 5, 1, 9, 2};
        System.out.println("Max Integer: " + findMax(intArray));

        Double[] doubleArray = {2.3, 4.5, 1.2, 9.8, 7.6};
        System.out.println("Max Double: " + findMax(doubleArray));

        Character[] charArray = {'a', 'x', 'b', 'z', 'c'};
        System.out.println("Max Character: " + findMax(charArray));

        String[] strArray = {"apple", "banana", "pear", "orange"};
        System.out.println("Max String: " + findMax(strArray));
    }
}
