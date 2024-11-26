
import java.util.LinkedList;
import java.util.Scanner;

public class Program {

    public static void processPayment() throws InvalidPaymentException {
        Scanner sc = new Scanner(System.in);
        System.out.println("Введіть суму платежу");
        int a = sc.nextInt();
        if (a <= 0) {
            throw new InvalidPaymentException("Сума платежу повинна бути більше 0.");
        }
        System.out.println("Платіж на суму " + a + " пройшов успішно.");
    }

    public static void main(String[] args) {

        try {
            processPayment();
        } catch (InvalidPaymentException e) {
            System.out.println("Помилка: " + e.getMessage());
        }

        LinkedList<Payment> ll = new LinkedList<Payment>();
        ll.add(new Payment(4));
        ll.add(new Payment(2));
        System.out.println("Сума елементів: ");
        System.out.println(Collections.sum(ll));
        Collections.remove(ll, 0);
    }
}
