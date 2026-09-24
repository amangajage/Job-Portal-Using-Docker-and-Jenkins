<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<nav class="navbar navbar-expand-lg navbar-dark jp-navbar">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <span class="brand-mark"><i class="fa-solid fa-briefcase"></i></span>
            <span>Job Portal</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#jpNavbar" aria-controls="jpNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="jpNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fa-solid fa-house me-1"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                <c:if test="${not empty userobj and userobj.role eq 'user'}">
                    <li class="nav-item"><a class="nav-link" href="home.jsp"><i class="fa-solid fa-magnifying-glass me-1"></i> Find Jobs</a></li>
                    <li class="nav-item"><a class="nav-link" href="dashboard.jsp"><i class="fa-solid fa-chart-simple me-1"></i> My Dashboard</a></li>
                </c:if>
                <c:if test="${not empty userobj and userobj.role eq 'admin'}">
                    <li class="nav-item"><a class="nav-link" href="admin.jsp"><i class="fa-solid fa-gauge-high me-1"></i> Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="add_job.jsp"><i class="fa-solid fa-plus me-1"></i> Post Job</a></li>
                    <li class="nav-item"><a class="nav-link" href="view_job.jsp"><i class="fa-solid fa-list-check me-1"></i> Manage Jobs</a></li>
                </c:if>
            </ul>

            <div class="navbar-actions">
                <c:if test="${not empty userobj and userobj.role eq 'admin'}">
                    <button type="button" class="btn btn-sm btn-nav-outline" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="fa-solid fa-user-shield me-1"></i> Admin</button>
                    <a href="logout" class="btn btn-sm btn-nav-light"><i class="fa-solid fa-arrow-right-from-bracket me-1"></i> Logout</a>
                </c:if>
                <c:if test="${not empty userobj and userobj.role eq 'user'}">
                    <button type="button" class="btn btn-sm btn-nav-outline" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="fa-solid fa-user me-1"></i> ${userobj.name}</button>
                    <a href="logout" class="btn btn-sm btn-nav-light"><i class="fa-solid fa-arrow-right-from-bracket me-1"></i> Logout</a>
                </c:if>
                <c:if test="${empty userobj}">
                    <a href="login.jsp" class="btn btn-sm btn-nav-outline"><i class="fa-solid fa-right-to-bracket me-1"></i> Login</a>
                    <a href="signup.jsp" class="btn btn-sm btn-nav-light"><i class="fa-solid fa-user-plus me-1"></i> Sign Up</a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<c:if test="${not empty userobj}">
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0">
            <div class="modal-header">
                <div><div class="text-uppercase small fw-semibold text-muted">Account</div><h5 class="modal-title" id="exampleModalLabel">Profile</h5></div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-3">
                <div class="profile-card p-4">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="profile-avatar"><i class="fa-solid fa-user"></i></div>
                        <div><div class="fw-semibold">${userobj.name}</div><div class="small text-white-50">${userobj.role}</div></div>
                    </div>
                    <table class="table profile-table mb-0"><tbody>
                        <tr><th>Name</th><td>${userobj.name}</td></tr>
                        <tr><th>Qualification</th><td>${userobj.qualification}</td></tr>
                        <tr><th>Email</th><td>${userobj.email}</td></tr>
                    </tbody></table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-jp-secondary" data-bs-dismiss="modal">Close</button>
                <c:if test="${userobj.role eq 'user'}"><a href="edit_profile.jsp" class="btn btn-jp-primary">Edit Profile</a></c:if>
                <c:if test="${userobj.role eq 'user'}"><a href="dashboard.jsp" class="btn btn-jp-secondary">My Dashboard</a></c:if>
            </div>
        </div>
    </div>
</div>
</c:if>
