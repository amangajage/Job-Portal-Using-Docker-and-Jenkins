package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.DB.DBConnect;
import com.dao.ApplicationDAO;
import com.entity.User;

@WebServlet("/update_application")
public class UpdateApplicationStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userobj");
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");
            boolean ok = new ApplicationDAO(DBConnect.getconn()).updateStatus(id, status);
            session.setAttribute("succMsg", ok ? "Application status updated." : "Could not update application status.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("succMsg", "Could not update application status.");
        }
        resp.sendRedirect("admin.jsp#applications");
    }
}
