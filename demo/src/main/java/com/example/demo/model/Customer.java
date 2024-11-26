package com.example.demo.model;


public class Customer {
    private int id;
    private String customerName;
    private String contactInfo;

    // Конструктор
    public Customer(int id, String customerName, String contactInfo) {
        this.id = id;
        this.customerName = customerName;
        this.contactInfo = contactInfo;
    }

    // Геттери
    public int getId() {
        return id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    // Сеттер для можливості оновлення значень, якщо потрібно
    public void setId(int id) {
        this.id = id;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }
}
