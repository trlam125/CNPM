package com.example.web;

import com.example.dao.ManagerDAO;
import com.example.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private final ManagerDAO managerDAO = new ManagerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isLogin(req, resp)) return;
        req.getRequestDispatcher("change-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isLogin(req, resp)) return;

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("loginUser");

        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (!user.getPassword().equals(oldPassword)) {
            req.setAttribute("error", "Mật khẩu cũ không đúng");
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Xác nhận mật khẩu không khớp");
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
            return;
        }

        boolean updated = managerDAO.changePassword(user.getId(), newPassword);
        if (updated) {
            user.setPassword(newPassword);
            session.setAttribute("loginUser", user);
            req.setAttribute("message", "Đổi mật khẩu thành công");
        } else {
            req.setAttribute("error", "Đổi mật khẩu thất bại");
        }

        req.getRequestDispatcher("change-password.jsp").forward(req, resp);
    }

    private boolean isLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}