<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.CustomerDebt" %>
<%
    List<CustomerDebt> customerDebts = (List<CustomerDebt>) request.getAttribute("customerDebts");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Khách hàng theo dư nợ</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background: #f0f0f0; }
    </style>
</head>
<body>
    <h2>Danh sách khách hàng theo dư nợ</h2>
    <p><a href="<%= request.getContextPath() %>/dashboard">Quay lại dashboard</a></p>

    <table>
        <tr>
            <th>ID</th>
            <th>Họ tên</th>
            <th>SĐT</th>
            <th>Địa chỉ</th>
            <th>Tổng dư nợ</th>
        </tr>
        <%
            if (customerDebts != null) {
                for (CustomerDebt c : customerDebts) {
        %>
        <tr>
            <td><%= c.getCustomerId() %></td>
            <td><%= c.getFullName() %></td>
            <td><%= c.getPhone() %></td>
            <td><%= c.getAddress() %></td>
            <td><%= c.getTotalDebt() %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>