
public class Payment {

    int sum;
    int id;
    static int idCount = 0;

    public Payment(int sum) {
        this.sum = sum;
        id = idCount++;
    }

    int getId() {
        return id;
    }
}
