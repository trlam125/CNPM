<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.Contract" %>
<%
    Contract c = (Contract) request.getAttribute("contract");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết hợp đồng</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .box { background: #f7f7f7; padding: 20px; border-radius: 8px; }
        p { margin: 8px 0; }
        a.button { padding: 8px 12px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
    <h2>Chi tiết hợp đồng</h2>
    <p><a href="<%= request.getContextPath() %>/dashboard">Quay lại dashboard</a></p>

    <%
        if (c != null) {
    %>
    <div class="box">
        <p><strong>ID:</strong> <%= c.getId() %></p>
        <p><strong>Mã hợp đồng:</strong> <%= c.getContractCode() %></p>
        <p><strong>Khách hàng:</strong> <%= c.getCustomerName() %></p>
        <p><strong>SĐT:</strong> <%= c.getPhone() %></p>
        <p><strong>Địa chỉ:</strong> <%= c.getAddress() %></p>
        <p><strong>Đối tác:</strong> <%= c.getPartnerName() %></p>
        <p><strong>Ngày ký:</strong> <%= c.getSignDate() %></p>
        <p><strong>Tổng tiền vay:</strong> <%= c.getTotalLoan() %></p>
        <p><strong>Số tháng:</strong> <%= c.getTermMonths() %></p>
        <p><strong>Lãi suất:</strong> <%= c.getInterestRate() %></p>
        <p><strong>Dư nợ còn lại:</strong> <%= c.getRemainingBalance() %></p>
        <p><strong>Trạng thái:</strong> <%= c.getStatus() %></p>

        <br>
        <a class="button" href="<%= request.getContextPath() %>/installments?contractId=<%= c.getId() %>">
            Xem kỳ thanh toán
        </a>
    </div>
    <%
        } else {
    %>
    <p>Không tìm thấy hợp đồng.</p>
    <%
        }
    %>
</body>
</html>