<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Profile | Job Portal</title>
    <%@include file="all_component/all_css.jsp"%>
</head>
<body>
    <c:if test="${empty userobj or userobj.role ne 'user'}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>
    <%@include file="all_component/navbar.jsp"%>

    <main class="container section-space py-5">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-xl-6">
                <div class="form-card">
                    <div class="section-kicker">Account settings</div>
                    <h1 class="form-card-title mt-2">Edit your profile</h1>
                    <p class="form-card-subtitle">Keep your contact and qualification details current.</p>

                    <c:if test="${not empty succMsg}">
                        <div class="alert alert-success" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i>${succMsg}
                        </div>
                        <c:remove var="succMsg" />
                    </c:if>

                    <form action="update_profile" method="post">
                        <input type="hidden" name="id" value="${userobj.id}">

                        <div class="mb-3">
                            <label class="form-label" for="profileName">Full name</label>
                            <input type="text" class="form-control" id="profileName" name="name" value="${userobj.name}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="profileQualification">Qualification</label>
                            <input type="text" class="form-control" id="profileQualification" name="qualification" value="${userobj.qualification}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="profileEmail">Email</label>
                            <input type="email" class="form-control" id="profileEmail" name="email" value="${userobj.email}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="profilePassword">Password</label>
                            <input type="password" class="form-control" id="profilePassword" name="password" value="${userobj.password}" required>
                        </div>

                        <div class="form-actions">
                            <a href="home.jsp" class="btn btn-jp-secondary">Cancel</a>
                            <button type="submit" class="btn btn-jp-primary px-4"><i class="fa-solid fa-floppy-disk me-1"></i> Save Profile</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <%@include file="all_component/footer.jsp"%>
</body>
</html>
