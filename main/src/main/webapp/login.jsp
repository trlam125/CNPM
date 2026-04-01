<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <style>
        body { font-family: Arial; background: #f4f6f9; }
        .box { width: 400px; margin: 80px auto; background: white; padding: 25px; border-radius: 8px; }
        input { width: 100%; padding: 10px; margin: 8px 0; }
        button { padding: 10px 16px; background: #007bff; color: white; border: none; cursor: pointer; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>
<div class="box">
    <h2>Đăng nhập Manager</h2>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>

    <form method="post" action="<%= request.getContextPath() %>/login">
        <label>Tài khoản</label>
        <input type="text" name="username" required>

        <label>Mật khẩu</label>
        <input type="password" name="password" required>

        <button type="submit">Đăng nhập</button>
    </form>
</div>
</body>
</html>