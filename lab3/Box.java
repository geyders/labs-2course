
public class Box<T> {

    private T item;

    public void put(T item) {
        this.item = item;
    }

    public T get() {
        return item;
    }

    public static void main(String[] args) {

        Box<Integer> intBox = new Box<>();
        intBox.put(123);
        System.out.println("Integer in the box: " + intBox.get());

        Box<String> strBox = new Box<>();
        strBox.put("Hello, World!");
        System.out.println("String in the box: " + strBox.get());

        Box<Double> doubleBox = new Box<>();
        doubleBox.put(3.1415);
        System.out.println("Double in the box: " + doubleBox.get());
    }
}
