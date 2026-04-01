package com.example.web;

import com.example.dao.ManagerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/overdue")
public class OverdueServlet extends HttpServlet {
    private final ManagerDAO managerDAO = new ManagerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isLogin(req, resp)) return;

        req.setAttribute("overdueList", managerDAO.getOverdueList());
        req.getRequestDispatcher("overdue.jsp").forward(req, resp);
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