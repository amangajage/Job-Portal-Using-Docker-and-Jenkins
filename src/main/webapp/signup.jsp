<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Account | Job Portal</title>
    <%@include file="all_component/all_css.jsp"%>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>

    <main class="auth-page">
        <div class="container">
            <div class="auth-card">
                <div class="auth-brand"><i class="fa-solid fa-user-plus"></i></div>
                <h1>Create your account</h1>
                <p class="auth-subtitle">Register once and keep your profile ready for new opportunities.</p>

                <c:if test="${not empty succMsg}">
                    <div class="alert alert-success" role="alert">
                        <i class="fa-solid fa-circle-check me-2"></i>${succMsg}
                    </div>
                    <c:remove var="succMsg" />
                </c:if>

                <form action="add_user" method="post">
                    <div class="mb-3">
                        <label class="form-label" for="signupName">Full name</label>
                        <input type="text" class="form-control" id="signupName" name="name" placeholder="Your full name" autocomplete="name" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="signupQualification">Qualification</label>
                        <input type="text" class="form-control" id="signupQualification" name="qualification" placeholder="e.g. B.Tech, B.E., MBA" autocomplete="organization-title" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="signupEmail">Email</label>
                        <input type="email" class="form-control" id="signupEmail" name="email" placeholder="you@example.com" autocomplete="email" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="signupPassword">Create password</label>
                        <input type="password" class="form-control" id="signupPassword" name="password" placeholder="Choose a password" autocomplete="new-password" required>
                    </div>

                    <button type="submit" class="btn btn-jp-primary w-100 py-2">Create Account</button>
                </form>

                <div class="auth-footer-text">
                    Already registered? <a href="login.jsp">Sign in</a>
                </div>
            </div>
        </div>
    </main>

    <%@include file="all_component/footer.jsp"%>
</body>
</html>
