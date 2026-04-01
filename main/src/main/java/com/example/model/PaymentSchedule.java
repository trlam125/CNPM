package com.example.model;

import java.math.BigDecimal;
import java.sql.Date;

public class PaymentSchedule {
    private int id;
    private int installmentNo;
    private Date dueDate;
    private BigDecimal amountDue;
    private BigDecimal principalAmount;
    private BigDecimal interestAmount;
    private BigDecimal paidAmount;
    private BigDecimal remainingAfter;
    private String status;

    public PaymentSchedule() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getInstallmentNo() {
        return installmentNo;
    }

    public void setInstallmentNo(int installmentNo) {
        this.installmentNo = installmentNo;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public BigDecimal getAmountDue() {
        return amountDue;
    }

    public void setAmountDue(BigDecimal amountDue) {
        this.amountDue = amountDue;
    }

    public BigDecimal getPrincipalAmount() {
        return principalAmount;
    }

    public void setPrincipalAmount(BigDecimal principalAmount) {
        this.principalAmount = principalAmount;
    }

    public BigDecimal getInterestAmount() {
        return interestAmount;
    }

    public void setInterestAmount(BigDecimal interestAmount) {
        this.interestAmount = interestAmount;
    }

    public BigDecimal getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    public BigDecimal getRemainingAfter() {
        return remainingAfter;
    }

    public void setRemainingAfter(BigDecimal remainingAfter) {
        this.remainingAfter = remainingAfter;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}