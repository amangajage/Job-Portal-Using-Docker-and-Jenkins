<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.entity.Jobs"%><%@page import="com.entity.User"%><%@page import="com.DB.DBConnect"%><%@page import="com.dao.JobDAO"%><%@page import="com.dao.SavedJobDAO"%><%@page import="com.dao.ApplicationDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ page isELIgnored="false"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Job Details | Job Portal</title><%@include file="all_component/all_css.jsp"%></head><body>
<c:if test="${empty userobj}"><c:redirect url="login.jsp"></c:redirect></c:if><%@include file="all_component/navbar.jsp"%>
<%
int id=Integer.parseInt(request.getParameter("id")); JobDAO dao=new JobDAO(DBConnect.getconn()); Jobs j=dao.getJobById(id); User current=(User)session.getAttribute("userobj");
boolean saved=false, applied=false; if(current!=null && "user".equalsIgnoreCase(current.getRole()) && j!=null){ SavedJobDAO sd=new SavedJobDAO(DBConnect.getconn()); ApplicationDAO ad=new ApplicationDAO(DBConnect.getconn()); saved=sd.isSaved(current.getId(),id); applied=ad.hasApplied(current.getId(),id); }
%>
<div class="page-header"><div class="container"><div class="section-kicker">Job details</div><h1><%=j==null?"Job not found":j.getTitle()%></h1><p>Review the role before you decide to apply.</p></div></div>
<main class="container section-space pt-4">
<c:if test="${not empty succMsg}"><div class="alert alert-success border-0 shadow-sm"><i class="fa-solid fa-circle-check me-2"></i>${succMsg}</div><c:remove var="succMsg"/></c:if>
<% if(j==null){ %><div class="empty-state"><i class="fa-regular fa-circle-xmark d-block"></i><h3 class="h5" style="color:var(--jp-navy)">Job not found</h3><p class="mb-3">This job may have been removed.</p><a href="home.jsp" class="btn btn-jp-primary">Back to Jobs</a></div>
<% } else { String status=j.getStatus()==null?"":j.getStatus(); %>
<div class="detail-card"><div class="detail-title-row"><div><h2 class="detail-title"><%=j.getTitle()%></h2><div class="job-date mt-2">Published <%=j.getPdate()%></div></div><span class="status-badge <%= "Inactive".equalsIgnoreCase(status)?"inactive":"" %>"><%=status%></span></div>
<div class="job-meta mb-4"><span class="meta-chip"><i class="fa-solid fa-location-dot"></i><%=j.getLocation()%></span><span class="meta-chip"><i class="fa-solid fa-layer-group"></i><%=j.getCategory()%></span><span class="meta-chip"><i class="fa-solid fa-hashtag"></i>Job <%=j.getId()%></span></div>
<div class="border-top pt-4"><div class="section-kicker mb-2">Description</div><div class="detail-description"><%=j.getDescription()%></div></div>
<div class="action-panel mt-4"><div class="d-flex flex-wrap justify-content-between align-items-center gap-3"><div><div class="fw-semibold" style="color:var(--jp-navy)">Interested in this role?</div><div class="small muted-text">Save it for later or submit your application.</div></div><div class="d-flex flex-wrap gap-2">
<a href="home.jsp" class="btn btn-jp-secondary"><i class="fa-solid fa-arrow-left me-1"></i>Back</a>
<c:if test="${userobj.role eq 'user'}"><a href="save_job?id=<%=j.getId()%>&action=<%=saved?"unsave":"save"%>" class="btn btn-jp-secondary"><i class="fa-<%=saved?"solid":"regular"%> fa-bookmark me-1"></i><%=saved?"Saved":"Save Job"%></a><% if("Active".equalsIgnoreCase(status)){ %><% if(applied){ %><button class="btn btn-jp-primary" disabled><i class="fa-solid fa-check me-1"></i>Applied</button><% } else { %><a href="apply_job?id=<%=j.getId()%>" class="btn btn-jp-primary" onclick="return confirm('Submit your application for this job?');"><i class="fa-solid fa-paper-plane me-1"></i>Apply Now</a><% } %><% } %></c:if>
</div></div></div>
</div><% } %>
</main><%@include file="all_component/footer.jsp"%></body></html>
