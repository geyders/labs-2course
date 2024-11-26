import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;

// Клас для товарів
class Product {
    private String name;
    private int stock;

    public Product(String name, int stock) {
        this.name = name;
        this.stock = stock;
    }

    public String getName() {
        return name;
    }

    public int getStock() {
        return stock;
    }

    // перевіряє чи є достатньо товару на складі
    public boolean buyProduct(int quantity) {
        if (stock >= quantity) {
            stock -= quantity;
            return true;
        }
        return false;
    }
}

// Клас для кошика користувача

// ключ - назва товару, значення - кількість товару в кошику
class ShoppingCart {
    private Map<String, Integer> cart = new HashMap<>();

    // додає товар до кошика
    public void addProduct(String productName, int quantity) {
        cart.put(productName, cart.getOrDefault(productName, 0) + quantity);
    }

    // виводить вміст кошика
    public void showCart(String clientName) {
        System.out.println("Кошик покупця " + clientName + ": " + cart);
    }
}

// Клас для онлайн-магазину
class OnlineStore {
    private Map<String, Product> products = new HashMap<>();
    // забезпечує потокобезпечний доступ до процесу покупки. тільки один потік може змінювати кількість товару одночасно
    private final ReentrantLock lock = new ReentrantLock(); 
    private final Semaphore semaphore = new Semaphore(3); // Лише 3 користувачі можуть зайти одночасно

    public OnlineStore() {
        products.put("Телефон", new Product("Телефон", 5));
        products.put("Ноутбук", new Product("Ноутбук", 2));
        products.put("Навушники", new Product("Навушники", 10));
    }

    // здійснює покупку використовуючи блокування лок
    public boolean buy(String productName, int quantity, String clientName) throws InterruptedException {
        lock.lock();
        try {
            Product product = products.get(productName);
            if (product != null && product.buyProduct(quantity)) {
                System.out.println(clientName + " купив(ла) " + quantity + " " + productName);
                return true;
            } else {
                System.out.println(clientName + " не зміг(ла) купити " + productName);
                return false;
            }
        } finally {
            lock.unlock();
        }
    }

    // дозволяж увійти в магазин якщо є доступні місця (через семафор)
    public void enterStore(String clientName) throws InterruptedException {
        semaphore.acquire();
        System.out.println(clientName + " увійшов(ла) в магазин.");
    }

    // звільняє місце в магазині
    public void leaveStore(String clientName) {
        System.out.println(clientName + " залишив(ла) магазин.");
        semaphore.release();
    }
}

// Клас для покупця (потоку) 
class User extends Thread {
    private OnlineStore store;
    private ShoppingCart cart;
    private String clientName;

    public User(OnlineStore store, String clientName) {
        this.store = store;
        this.cart = new ShoppingCart();
        this.clientName = clientName;
    }

    @Override
    public void run() {
        try {
            store.enterStore(clientName);  // Клієнт входить у магазин
            if (store.buy("Телефон", 1, clientName)) {
                cart.addProduct("Телефон", 1);
            }
            cart.showCart(clientName);  // Виводимо кошик клієнта
            store.leaveStore(clientName);  // Клієнт виходить з магазину
        } catch (InterruptedException e) {
            System.out.println(clientName + " був(ла) перерваний(а).");
        }
    }
}

// Основний клас програми
public class OnlineStoreApp {
    public static void main(String[] args) {
        OnlineStore store = new OnlineStore();

        // Створюємо покупців із іменами
        User user1 = new User(store, "Іван");
        User user2 = new User(store, "Марія");
        User user3 = new User(store, "Петро");
        User user4 = new User(store, "Олена");

        // Запускаємо потоки (запускається як окремий потік за допомоггою старт)
        user1.start();
        user2.start();
        user3.start();
        user4.start();

        // Очікуємо завершення всіх потоків
        try {
            user1.join();
            user2.join();
            user3.join();
            user4.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Магазин завершив роботу.");
    }
}
