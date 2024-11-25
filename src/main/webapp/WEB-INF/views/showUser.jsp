<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    if (session.getAttribute("adminEmail") == null) {
        // Redirect to login page if session does not contain adminEmail
        response.sendRedirect(request.getContextPath() + "/productadmin");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .table-container {
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">User Dashboard</a>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="goowner">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
                        <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
                        <path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293z"/>
                    </svg>
                    Home
                </a>
            </li>
        </ul>
    </div>
</nav>

<div class="container my-5">
    <h2 class="text-center mb-4">User List</h2>

    <div class="table-container">
        <c:if test="${empty userlist}">
            <div class="alert alert-warning text-center">
                No users available.
            </div>
        </c:if>

        <table class="table table-hover table-bordered">
            <thead class="table-primary">
                <tr>
                    <th>User Code</th>
                    <th>Name</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${userlist}">
                    <tr>
                        <td>${user.u_code}</td>
                        <td><c:out value="${user.firstname}" /> <c:out value="${user.lastname}" /></td>
                        <td>${user.email}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>