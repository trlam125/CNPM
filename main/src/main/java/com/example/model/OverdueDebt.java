package com.example.model;

import java.math.BigDecimal;

public class OverdueDebt {
    private int contractId;
    private String contractCode;
    private String customerName;
    private BigDecimal overdueAmount;
    private int overdueDays;

    public OverdueDebt() {
    }

    public OverdueDebt(int contractId, String contractCode, String customerName, BigDecimal overdueAmount, int overdueDays) {
        this.contractId = contractId;
        this.contractCode = contractCode;
        this.customerName = customerName;
        this.overdueAmount = overdueAmount;
        this.overdueDays = overdueDays;
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public String getContractCode() {
        return contractCode;
    }

    public void setContractCode(String contractCode) {
        this.contractCode = contractCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public BigDecimal getOverdueAmount() {
        return overdueAmount;
    }

    public void setOverdueAmount(BigDecimal overdueAmount) {
        this.overdueAmount = overdueAmount;
    }

    public int getOverdueDays() {
        return overdueDays;
    }

    public void setOverdueDays(int overdueDays) {
        this.overdueDays = overdueDays;
    }
}