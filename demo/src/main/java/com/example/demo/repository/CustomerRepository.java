package com.example.demo.repository;

import com.example.demo.model.Customer; // Необхідно імплементувати клас Customer
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerRepository {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public CustomerRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Метод для збереження нового клієнта
    public int save(Customer customer) { // Зміна типу на Customer
        String sql = "INSERT INTO customers (id, customerName, contactInfo) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, customer.getId(), customer.getCustomerName(), customer.getContactInfo());
    }

    // Інші CRUD-методи: update, delete, find, etc.
}
