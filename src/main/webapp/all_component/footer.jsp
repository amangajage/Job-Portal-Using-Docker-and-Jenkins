<footer class="jp-footer">
    <div class="container">
        <div class="row g-4 align-items-center">
            <div class="col-md-7">
                <div class="jp-footer-brand"><i class="fa-solid fa-briefcase me-2"></i>Job Portal</div>
                <p>A straightforward platform for discovering job opportunities and managing applications.</p>
            </div>
            <div class="col-md-5 text-md-end jp-footer-links">
                <a href="index.jsp">Home</a>
                <c:if test="${not empty userobj and userobj.role eq 'user'}"><a href="home.jsp">Find Jobs</a><a href="dashboard.jsp">Dashboard</a></c:if>
                <a href="login.jsp">Login</a>
            </div>
        </div>
        <div class="border-top border-light border-opacity-10 mt-4 pt-3 small">© 2026 Job Portal. All rights reserved.</div>
    </div>
</footer>
