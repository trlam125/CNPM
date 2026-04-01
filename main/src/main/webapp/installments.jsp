<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.PaymentSchedule" %>
<%
    List<PaymentSchedule> installments = (List<PaymentSchedule>) request.getAttribute("installments");
    Integer contractId = (Integer) request.getAttribute("contractId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kỳ thanh toán</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background: #f0f0f0; }
    </style>
</head>
<body>
    <h2>Danh sách kỳ thanh toán - Hợp đồng ID <%= contractId %></h2>
    <p>
        <a href="<%= request.getContextPath() %>/contract-detail?id=<%= contractId %>">Quay lại chi tiết hợp đồng</a>
    </p>

    <table>
        <tr>
            <th>Kỳ</th>
            <th>Ngày đến hạn</th>
            <th>Số tiền đến hạn</th>
            <th>Tiền gốc</th>
            <th>Tiền lãi</th>
            <th>Đã thanh toán</th>
            <th>Còn lại sau kỳ</th>
            <th>Trạng thái</th>
        </tr>
        <%
            if (installments != null) {
                for (PaymentSchedule p : installments) {
        %>
        <tr>
            <td><%= p.getInstallmentNo() %></td>
            <td><%= p.getDueDate() %></td>
            <td><%= p.getAmountDue() %></td>
            <td><%= p.getPrincipalAmount() %></td>
            <td><%= p.getInterestAmount() %></td>
            <td><%= p.getPaidAmount() %></td>
            <td><%= p.getRemainingAfter() %></td>
            <td><%= p.getStatus() %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>