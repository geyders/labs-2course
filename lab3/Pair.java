import java.util.List;
import java.util.Objects;

public class Pair<T, U> {
    private T first;
    private U second;

    public Pair(T first, U second) {
        this.first = first;
        this.second = second;
    }

    public T getFirst() {
        return first;
    }

    public U getSecond() {
        return second;
    }

    public boolean isEqualTo(Pair<T, U> otherPair) {
        return Objects.equals(this.first, otherPair.first) &&
               Objects.equals(this.second, otherPair.second);
    }

    @Override
    public String toString() {
        return "Pair{" +
               "first=" + first +
               ", second=" + second +
               '}';
    }

    public static void main(String[] args) {
        Pair<Integer, String> pair1 = new Pair<>(1, "One");
        System.out.println("Pair1: " + pair1);

        List<Integer> numberList = List.of(1, 2, 3, 4);
        Pair<String, List<Integer>> pair2 = new Pair<>("Numbers", numberList);
        System.out.println("Pair2: " + pair2);

        Pair<Integer, String> pair3 = new Pair<>(1, "One");
        System.out.println("Pair1 is equal to Pair3: " + pair1.isEqualTo(pair3));

        Pair<Integer, String> pair4 = new Pair<>(2, "Two");
        System.out.println("Pair1 is equal to Pair4: " + pair1.isEqualTo(pair4));
    }
}
