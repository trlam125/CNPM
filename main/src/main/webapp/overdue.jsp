<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.OverdueDebt" %>
<%
    List<OverdueDebt> overdueList = (List<OverdueDebt>) request.getAttribute("overdueList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nợ quá hạn</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background: #f0f0f0; }
        a.button { padding: 6px 10px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
    <h2>Danh sách nợ quá hạn</h2>
    <p><a href="<%= request.getContextPath() %>/dashboard">Quay lại dashboard</a></p>

    <table>
        <tr>
            <th>ID Hợp đồng</th>
            <th>Mã hợp đồng</th>
            <th>Khách hàng</th>
            <th>Số tiền quá hạn</th>
            <th>Số ngày quá hạn</th>
            <th>Chi tiết</th>
        </tr>
        <%
            if (overdueList != null) {
                for (OverdueDebt o : overdueList) {
        %>
        <tr>
            <td><%= o.getContractId() %></td>
            <td><%= o.getContractCode() %></td>
            <td><%= o.getCustomerName() %></td>
            <td><%= o.getOverdueAmount() %></td>
            <td><%= o.getOverdueDays() %></td>
            <td>
                <a class="button" href="<%= request.getContextPath() %>/contract-detail?id=<%= o.getContractId() %>">
                    Xem
                </a>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>