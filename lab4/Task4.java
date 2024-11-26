import java.util.*;
import java.util.stream.Collectors;

class Employee {
    private String name;
    private double salary;

    public Employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
    }

    public String getName() {
        return name;
    }

    public double getSalary() {
        return salary;
    }

    @Override
    public String toString() {
        return "Employee{name='" + name + "', salary=" + salary + '}';
    }
}

public class Task4 {

    // Метод для визначення діапазону зарплати
    public static String getSalaryRange(double salary) {
        if (salary < 3000) {
            return "< 3000";
        } else if (salary <= 5000) {
            return "3000-5000";
        } else {
            return "> 5000";
        }
    }

    // Метод для групування працівників за діапазоном зарплати та пошуку найвищої зарплати в кожній групі
    public static Map<String, Optional<Employee>> groupAndFindHighestPaid(List<Employee> employees) {
        return employees.stream()
            .collect(Collectors.groupingBy(
                emp -> getSalaryRange(emp.getSalary()),   // Групування за діапазоном зарплати
                Collectors.maxBy(Comparator.comparingDouble(Employee::getSalary)) // Знаходимо працівника з найвищою зарплатою в кожній групі
            ));
    }

    public static void main(String[] args) {
        // Приклад списку співробітників
        List<Employee> employees = Arrays.asList(
            new Employee("John", 2500),
            new Employee("Jane", 3200),
            new Employee("Tom", 5000),
            new Employee("Emily", 6000),
            new Employee("Max", 7000),
            new Employee("Anna", 2800)
        );

        // Виклик методу для групування та пошуку працівника з найвищою зарплатою в кожній групі
        Map<String, Optional<Employee>> result = groupAndFindHighestPaid(employees);

        // Виведення результатів
        result.forEach((range, employee) -> {
            System.out.println("Діапазон зарплат " + range + ": " + employee.orElse(null));
        });
    }
}
