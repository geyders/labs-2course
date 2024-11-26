
import java.util.LinkedList;

class Collections {

    public static Integer sum(LinkedList<Payment> ll) {
        int sum = 0;
        int i = 0; //index
        while (i < ll.size()) {
            sum += ll.get(i).sum;
            i++;
        }

        return sum;
    }

    public static Payment search(LinkedList<Payment> ll, int id) {
        for (int i = 0; i < ll.size(); i++) {
            Payment payment = ll.get(i);
            System.out.println(ll.get(i));
            if (id < 0 || id >= ll.size()) {
                throw new IndexOutOfBoundsException("ID out of bounds: " + id);
            }

            if (payment.getId() == id) {
                return payment; 
            }

        }
        return null;
    }

    public static void remove(LinkedList<Payment> ll, int id) {
        Payment p = search(ll, id);
        System.out.println("Deleted:\nid:" + p.id);
        System.out.println("sum:" + p.sum);
        ll.remove(p);

    }
}
