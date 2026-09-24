<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Post a Job | Job Portal</title>
    <%@include file="all_component/all_css.jsp"%>
</head>
<body>
    <c:if test="${userobj.role ne 'admin'}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>
    <%@include file="all_component/navbar.jsp"%>

    <main class="container section-space py-5">
        <div class="row justify-content-center">
            <div class="col-xl-9">
                <div class="form-card">
                    <div class="section-kicker">Employer tools</div>
                    <h1 class="form-card-title mt-2">Publish a new job</h1>
                    <p class="form-card-subtitle">Add the role information that candidates will see on the portal.</p>

                    <c:if test="${not empty succMsg}">
                        <div class="alert alert-success" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i>${succMsg}
                        </div>
                        <c:remove var="succMsg" />
                    </c:if>

                    <form action="add_job" method="post">
                        <div class="mb-3">
                            <label class="form-label" for="jobTitle">Job title</label>
                            <input type="text" class="form-control" id="jobTitle" name="title" placeholder="e.g. Java Developer" required>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label" for="jobLocation">Location</label>
                                <select name="location" class="form-select" id="jobLocation" required>
                                    <option value="" selected disabled>Select location</option>
                                    <option value="Bangalore">Bangalore</option>
                                    <option value="Baroda">Baroda</option>
                                    <option value="Chandigarh">Chandigarh</option>
                                    <option value="Coimbatore">Coimbatore</option>
                                    <option value="Chennai">Chennai</option>
                                    <option value="Delhi-NCR">Delhi</option>
                                    <option value="Dhule">Dhule</option>
                                    <option value="Hydrabad">Hydrabad</option>
                                    <option value="Kolkata">Kolkata</option>
                                    <option value="Mumbai">Mumbai</option>
                                    <option value="Pune">Pune</option>
                                    <option value="Shirpur">Shirpur</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label" for="jobCategory">Category</label>
                                <select name="category" class="form-select" id="jobCategory" required>
                                    <option value="" selected disabled>Select category</option>
                                    <option value="IT">IT</option>
                                    <option value="Devloper">Developer</option>
                                    <option value="Banking">Banking</option>
                                    <option value="Engineer">Engineer</option>
                                    <option value="Teacher">Teacher</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label" for="jobStatus">Status</label>
                                <select class="form-select" id="jobStatus" name="status" required>
                                    <option value="Active" selected>Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>
                        </div>

                        <div class="mt-3">
                            <label class="form-label" for="jobDescription">Description</label>
                            <textarea required rows="7" name="desc" id="jobDescription" class="form-control" placeholder="Describe the role, responsibilities, and expectations."></textarea>
                        </div>

                        <div class="form-actions">
                            <a href="admin.jsp" class="btn btn-jp-secondary">Cancel</a>
                            <button type="submit" class="btn btn-jp-primary px-4"><i class="fa-solid fa-paper-plane me-1"></i> Publish Job</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <%@include file="all_component/footer.jsp"%>
</body>
</html>
