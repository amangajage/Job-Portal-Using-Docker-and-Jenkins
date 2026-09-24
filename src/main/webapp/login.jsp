<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign In | Job Portal</title>
    <%@include file="all_component/all_css.jsp"%>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>

    <main class="auth-page">
        <div class="container">
            <div class="auth-card">
                <div class="auth-brand"><i class="fa-solid fa-arrow-right-to-bracket"></i></div>
                <h1>Welcome back</h1>
                <p class="auth-subtitle">Sign in to continue to your Job Portal account.</p>

                <c:if test="${not empty succMsg}">
                    <div class="alert alert-light border mb-4" role="alert">
                        <i class="fa-solid fa-circle-info me-2 text-secondary"></i>${succMsg}
                    </div>
                    <c:remove var="succMsg" />
                </c:if>

                <form action="login" method="post">
                    <div class="mb-3">
                        <label class="form-label" for="loginEmail">Email</label>
                        <input type="email" class="form-control" id="loginEmail" name="email" placeholder="you@example.com" autocomplete="email" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="loginPassword">Password</label>
                        <input type="password" class="form-control" id="loginPassword" name="password" placeholder="Enter your password" autocomplete="current-password" required>
                    </div>

                    <button type="submit" class="btn btn-jp-primary w-100 py-2">Sign In</button>
                </form>

                <div class="auth-footer-text">
                    Don't have an account? <a href="signup.jsp">Create one</a>
                </div>
            </div>
        </div>
    </main>

    <%@include file="all_component/footer.jsp"%>
</body>
</html>
