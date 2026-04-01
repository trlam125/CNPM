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
    <title>Dashboard</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f6f8fb; }
        .menu a { margin-right: 15px; }
        .card { display: inline-block; width: 280px; background: white; padding: 15px; margin: 10px 10px 20px 0; border-radius: 8px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background: #f0f0f0; }
    </style>
</head>
<body>
    <h1>Dashboard Manager</h1>

    <div class="menu">
        <a href="<%= request.getContextPath() %>/dashboard">Trang chủ</a>
        <a href="<%= request.getContextPath() %>/customer-debt">Khách hàng theo dư nợ</a>
        <a href="<%= request.getContextPath() %>/overdue">Nợ quá hạn</a>
        <a href="<%= request.getContextPath() %>/change-password">Đổi mật khẩu</a>
        <a href="<%= request.getContextPath() %>/logout">Đăng xuất</a>
    </div>

    <div class="card">
        <h3>Tổng dư nợ</h3>
        <p><strong><%= request.getAttribute("totalDebt") %></strong></p>
    </div>

    <div class="card">
        <h3>Tổng nợ quá hạn</h3>
        <p><strong><%= request.getAttribute("overdueDebt") %></strong></p>
    </div>

    <h2>Danh sách khách hàng theo dư nợ</h2>
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