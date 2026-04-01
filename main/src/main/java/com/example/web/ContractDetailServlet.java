package com.example.web;

import com.example.dao.ManagerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/contract-detail")
public class ContractDetailServlet extends HttpServlet {
    private final ManagerDAO managerDAO = new ManagerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isLogin(req, resp)) return;

        String idRaw = req.getParameter("id");
        if (idRaw == null || idRaw.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        int contractId = Integer.parseInt(idRaw);
        req.setAttribute("contract", managerDAO.getContractDetail(contractId));
        req.getRequestDispatcher("contract-detail.jsp").forward(req, resp);
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