package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.DB.DBConnect;
import com.dao.SavedJobDAO;
import com.entity.User;

@WebServlet("/save_job")
public class SaveJobServlet extends HttpServlet {
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
            String action = req.getParameter("action");
            SavedJobDAO dao = new SavedJobDAO(DBConnect.getconn());
            boolean ok = "unsave".equalsIgnoreCase(action)
                    ? dao.unsaveJob(user.getId(), jobId)
                    : dao.saveJob(user.getId(), jobId);
            session.setAttribute("succMsg", ok ? ("unsave".equalsIgnoreCase(action) ? "Job removed from saved jobs." : "Job saved to your profile.") : "No changes were made.");
            resp.sendRedirect("one_view.jsp?id=" + jobId);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("home.jsp");
        }
    }
}
