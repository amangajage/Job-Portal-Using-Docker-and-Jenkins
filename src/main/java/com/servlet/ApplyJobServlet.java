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

@WebServlet("/apply_job")
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userobj");
        if (user == null || !"user".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }
        try {
            int jobId = Integer.parseInt(req.getParameter("id"));
            ApplicationDAO dao = new ApplicationDAO(DBConnect.getconn());
            boolean ok = dao.apply(user.getId(), jobId);
            session.setAttribute("succMsg", ok ? "Application submitted successfully." : "You may have already applied for this job.");
            resp.sendRedirect("one_view.jsp?id=" + jobId);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("home.jsp");
        }
    }
}
