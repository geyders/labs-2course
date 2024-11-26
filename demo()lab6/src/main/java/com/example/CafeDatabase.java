package com.example;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Scanner;






public class CafeDatabase {
    private static final String CONFIG_FILE = "src/main/resources/config.properties"; // Файл конфігурації

    // Метод для підключення до бази даних
    public static Connection getConnection() throws IOException, SQLException {
        Properties props = new Properties();
        try (FileInputStream fis = new FileInputStream(CONFIG_FILE)) {
            props.load(fis);
        }
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String password = props.getProperty("db.password");

        return DriverManager.getConnection(url, user, password);
    }

    public static void main(String[] args) {
        try (Connection connection = getConnection()) {
            System.out.println("Підключено до бази даних!");

            Scanner scanner = new Scanner(System.in);
            boolean running = true;

            while (running) {
                System.out.println("\n--- МЕНЮ ---");
                System.out.println("1. Авторизуватися");
                System.out.println("2. Додати клієнта");
                System.out.println("3. Видалити клієнта");
                System.out.println("4. Історія замовлень");
                System.out.println("5. Улюблені страви чи напої клієнта");
                System.out.println("6. Клієнти за частотою відвідування");
                System.out.println("7. Вийти з програми");
                System.out.print("Виберіть опцію: ");

                int option = scanner.nextInt();
                scanner.nextLine(); // Споживаємо залишок рядка після вводу

                switch (option) {
                    case 1: authorizeUser(connection, scanner);
                    break;
                    case 2: addClient(connection, scanner);
                    break;
                    case 3: deleteClient(connection, scanner);
                    break;
                    case 4: printOrderHistory(connection);
                    break;
                    case 5: printFavoriteDishes(connection);
                    break;
                    case 6: printClientsByVisitCount(connection);
                    break;
                    case 7: {
                        System.out.println("Завершення програми...");
                        running = false;
                    }
                    break;
                    default: System.out.println("Невірний вибір. Спробуйте ще раз.");
                    break;
                }
            }

        } catch (IOException | SQLException e) {
            System.out.println("Помилка підключення до бази даних.");
            e.printStackTrace();
        }
    }

 // Метод для авторизації користувача
 private static void authorizeUser(Connection connection, Scanner scanner) throws SQLException {
    System.out.print("Введіть ім'я користувача: ");
    String username = scanner.nextLine();

    System.out.print("Введіть пароль: ");
    String password = scanner.nextLine();

    String query = "SELECT password FROM users WHERE name = ?";
    try (PreparedStatement stmt = connection.prepareStatement(query)) {
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            String storedHash = rs.getString("password");
            if (PasswordUtils.hashPassword(password).equals(storedHash)) {
                System.out.println("Авторизація успішна!");
            } else {
                System.out.println("Невірний пароль.");
            }
        } else {
            System.out.println("Користувача не знайдено.");
        }
    }
}

    // Метод для додавання клієнта
    private static void addClient(Connection connection, Scanner scanner) throws SQLException {
        System.out.print("Введіть ПІБ клієнта: ");
        String fullName = scanner.nextLine();

        System.out.print("Введіть дату народження (YYYY-MM-DD): ");
        String birthDateStr = scanner.nextLine();
        Date birthDate = Date.valueOf(birthDateStr);

        String query = "INSERT INTO clients (full_name, birth_date) VALUES (?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, fullName);
            stmt.setDate(2, birthDate);
            stmt.executeUpdate();
            System.out.println("Клієнт доданий!");
        }
    }

    // Метод для видалення клієнта
    private static void deleteClient(Connection connection, Scanner scanner) throws SQLException {
        System.out.print("Введіть ID клієнта для видалення: ");
        int clientId = scanner.nextInt();

        String query = "DELETE FROM clients WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, clientId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Клієнт видалений!");
            } else {
                System.out.println("Клієнта з таким ID не знайдено.");
            }
        }
    }

    // Метод для виведення історії замовлень
private static void printOrderHistory(Connection connection) throws SQLException {
    String query = 
        "SELECT o.order_date, c.full_name AS Client, e.full_name AS Employee, o.total_price " +
        "FROM orders o " +
        "JOIN clients c ON o.client_id = c.id " +
        "JOIN employees e ON o.employee_id = e.id " +
        "ORDER BY o.order_date;";

    try (Statement stmt = connection.createStatement();
         ResultSet rs = stmt.executeQuery(query)) {

        System.out.println("Історія замовлень:");
        while (rs.next()) {
            String client = rs.getString("client_id");
            String employee = rs.getString("employee_id");
            String date = rs.getString("order_date");
            double price = rs.getDouble("total_price");

            System.out.printf("Дата: %s, Клієнт: %s, Працівник: %s, Ціна: %.2f\n",
                    date, client, employee, price);
        }
    }
}


    // Метод для виведення улюблених страв або напоїв клієнта
private static void printFavoriteDishes(Connection connection) throws SQLException {
    String query = 
        "SELECT c.full_name AS Client, d.name AS FavoriteDish " +
        "FROM clients c" +
        "JOIN favorite_dishes fd ON c.id = fd.client_id " +
        "JOIN dishes d ON fd.dish_id = d.id;";

    try (Statement stmt = connection.createStatement();
         ResultSet rs = stmt.executeQuery(query)) {

        System.out.println("Улюблені страви чи напої клієнтів:");
        while (rs.next()) {
            String client = rs.getString("Client");
            String dish = rs.getString("FavoriteDish");
            System.out.printf("Клієнт: %s, Улюблена страва/напій: %s\n", client, dish);
        }
    }
}


    // Метод для виведення клієнтів за частотою відвідування
private static void printClientsByVisitCount(Connection connection) throws SQLException {
    String query = 
        "SELECT c.full_name, COUNT(o.id) AS VisitCount " +
        "FROM clients c " +
        "JOIN orders o ON c.id = o.client_id " +
        "GROUP BY c.id " +
        "ORDER BY VisitCount DESC;";

    try (Statement stmt = connection.createStatement();
         ResultSet rs = stmt.executeQuery(query)) {

        System.out.println("Клієнти за частотою відвідування:");
        while (rs.next()) {
            String client = rs.getString("full_name");
            int visitCount = rs.getInt("VisitCount");
            System.out.printf("Клієнт: %s, Кількість відвідувань: %d\n", client, visitCount);
        }
    }
}
}

