<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>
    <style>
        body { font-family: Arial; background: #f4f6f9; }
        .box { width: 450px; margin: 60px auto; background: white; padding: 25px; border-radius: 8px; }
        input { width: 100%; padding: 10px; margin: 8px 0; }
        button { padding: 10px 16px; background: green; color: white; border: none; }
        .error { color: red; }
        .message { color: green; }
    </style>
</head>
<body>
<div class="box">
    <h2>Đổi mật khẩu</h2>

    <p><a href="<%= request.getContextPath() %>/dashboard">Quay lại dashboard</a></p>

    <%
        String error = (String) request.getAttribute("error");
        String message = (String) request.getAttribute("message");
        if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
        if (message != null) {
    %>
        <div class="message"><%= message %></div>
    <%
        }
    %>

    <form method="post" action="<%= request.getContextPath() %>/change-password">
        <label>Mật khẩu cũ</label>
        <input type="password" name="oldPassword" required>

        <label>Mật khẩu mới</label>
        <input type="password" name="newPassword" required>

        <label>Nhập lại mật khẩu mới</label>
        <input type="password" name="confirmPassword" required>

        <button type="submit">Cập nhật</button>
    </form>
</div>
</body>
</html>