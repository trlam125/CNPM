package com.example.model;

import java.math.BigDecimal;

public class CustomerDebt {
    private int customerId;
    private String fullName;
    private String phone;
    private String address;
    private BigDecimal totalDebt;

    public CustomerDebt() {
    }

    public CustomerDebt(int customerId, String fullName, String phone, String address, BigDecimal totalDebt) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.totalDebt = totalDebt;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public BigDecimal getTotalDebt() {
        return totalDebt;
    }

    public void setTotalDebt(BigDecimal totalDebt) {
        this.totalDebt = totalDebt;
    }
}