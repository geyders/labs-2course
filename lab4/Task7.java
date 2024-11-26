import java.util.*;
import java.util.stream.Collectors;

class Transaction {
    private double amount;
    private String category;

    public Transaction(double amount, String category) {
        this.amount = amount;
        this.category = category;
    }

    public double getAmount() {
        return amount;
    }

    public String getCategory() {
        return category;
    }
}

public class Task7 {

    // Метод для фільтрації транзакцій за категоріями та підсумування сум
    public static Map<String, Double> summarizeTransactionsByCategory(List<Transaction> transactions) {
        return transactions.stream()
            .collect(Collectors.groupingBy(                   // Групуємо транзакції за категоріями
                Transaction::getCategory,                     // Ключ Map — це категорія
                Collectors.summingDouble(Transaction::getAmount) // Значення — підсумок сум транзакцій
            ));
    }

    public static void main(String[] args) {
        List<Transaction> transactions = Arrays.asList(
            new Transaction(100.0, "Food"),
            new Transaction(200.0, "Entertainment"),
            new Transaction(50.0, "Food"),
            new Transaction(150.0, "Utilities"),
            new Transaction(300.0, "Entertainment")
        );

        // Виклик методу для фільтрації та підсумування
        Map<String, Double> result = summarizeTransactionsByCategory(transactions);

        // Виведення результату
        result.forEach((category, total) -> 
            System.out.println("Категорія: " + category + ", Загальна сума: " + total)
        );
    }
}
