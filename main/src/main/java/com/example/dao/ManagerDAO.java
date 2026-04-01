package com.example.dao;

import com.example.model.Contract;
import com.example.model.CustomerDebt;
import com.example.model.OverdueDebt;
import com.example.model.PaymentSchedule;
import com.example.model.User;
import com.example.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ManagerDAO {

    public User login(String username, String password) {
        String sql = "SELECT * FROM tblUsers WHERE username = ? AND password = ? AND role = 'MANAGER'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("role")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean changePassword(int userId, String newPassword) {
        String sql = "UPDATE tblUsers SET password = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public BigDecimal getTotalDebt() {
        String sql = "SELECT COALESCE(SUM(remaining_balance), 0) AS total_debt FROM tblContracts";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getBigDecimal("total_debt");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal getOverdueDebt() {
        String sql = "SELECT COALESCE(SUM(amount_due - paid_amount), 0) AS overdue_debt " +
                     "FROM tblPaymentSchedules " +
                     "WHERE status = 'OVERDUE'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getBigDecimal("overdue_debt");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public List<CustomerDebt> getCustomerDebtList() {
        List<CustomerDebt> list = new ArrayList<>();
        String sql = "SELECT c.id, c.full_name, c.phone, c.address, " +
                     "COALESCE(SUM(ct.remaining_balance), 0) AS total_debt " +
                     "FROM tblCustomers c " +
                     "LEFT JOIN tblContracts ct ON c.id = ct.customer_id " +
                     "GROUP BY c.id, c.full_name, c.phone, c.address " +
                     "ORDER BY total_debt DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CustomerDebt item = new CustomerDebt(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getBigDecimal("total_debt")
                );
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OverdueDebt> getOverdueList() {
        List<OverdueDebt> list = new ArrayList<>();
        String sql = "SELECT ct.id, ct.contract_code, c.full_name, " +
                     "(ps.amount_due - ps.paid_amount) AS overdue_amount, " +
                     "DATEDIFF(CURDATE(), ps.due_date) AS overdue_days " +
                     "FROM tblPaymentSchedules ps " +
                     "JOIN tblContracts ct ON ps.contract_id = ct.id " +
                     "JOIN tblCustomers c ON ct.customer_id = c.id " +
                     "WHERE ps.status = 'OVERDUE' " +
                     "ORDER BY overdue_days DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OverdueDebt item = new OverdueDebt(
                        rs.getInt("id"),
                        rs.getString("contract_code"),
                        rs.getString("full_name"),
                        rs.getBigDecimal("overdue_amount"),
                        rs.getInt("overdue_days")
                );
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Contract getContractDetail(int contractId) {
        String sql = "SELECT ct.id, ct.contract_code, ct.sign_date, ct.total_loan, ct.term_months, " +
                     "ct.interest_rate, ct.remaining_balance, ct.status, " +
                     "c.full_name, c.phone, c.address, p.partner_name " +
                     "FROM tblContracts ct " +
                     "JOIN tblCustomers c ON ct.customer_id = c.id " +
                     "JOIN tblPartners p ON ct.partner_id = p.id " +
                     "WHERE ct.id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, contractId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Contract contract = new Contract();
                    contract.setId(rs.getInt("id"));
                    contract.setContractCode(rs.getString("contract_code"));
                    contract.setSignDate(rs.getDate("sign_date"));
                    contract.setTotalLoan(rs.getBigDecimal("total_loan"));
                    contract.setTermMonths(rs.getInt("term_months"));
                    contract.setInterestRate(rs.getBigDecimal("interest_rate"));
                    contract.setRemainingBalance(rs.getBigDecimal("remaining_balance"));
                    contract.setStatus(rs.getString("status"));
                    contract.setCustomerName(rs.getString("full_name"));
                    contract.setPhone(rs.getString("phone"));
                    contract.setAddress(rs.getString("address"));
                    contract.setPartnerName(rs.getString("partner_name"));
                    return contract;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PaymentSchedule> getInstallments(int contractId) {
        List<PaymentSchedule> list = new ArrayList<>();
        String sql = "SELECT * FROM tblPaymentSchedules WHERE contract_id = ? ORDER BY installment_no";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, contractId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PaymentSchedule item = new PaymentSchedule();
                    item.setId(rs.getInt("id"));
                    item.setInstallmentNo(rs.getInt("installment_no"));
                    item.setDueDate(rs.getDate("due_date"));
                    item.setAmountDue(rs.getBigDecimal("amount_due"));
                    item.setPrincipalAmount(rs.getBigDecimal("principal_amount"));
                    item.setInterestAmount(rs.getBigDecimal("interest_amount"));
                    item.setPaidAmount(rs.getBigDecimal("paid_amount"));
                    item.setRemainingAfter(rs.getBigDecimal("remaining_after"));
                    item.setStatus(rs.getString("status"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}