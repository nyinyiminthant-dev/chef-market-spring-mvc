<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
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
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

 <style type="text/css">
 
 body {
 	background-color: black;
 }
 .error {
 color: red;
 }
 a{
   padding-left: 20px;
   text-decoration: none;
   color: black;
 }
 .contain {
 display: flex;
 align-items: center;
 justify-content: center;
 height: 650px;
 border: 1px solid black;
 }
 
 .form{
	width: 400px;
	height: 400px;
	padding: 20px;
	border-radius: 20px;
	background-color: white;
}
 </style>
</head>
<body>
<c:if test="${not empty sessionScope.successMessage}">
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '${sessionScope.successMessage}',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
    </script>
</c:if>



<div class = "contain">
	<form:form action="${pageContext.request.contextPath}/editcategory/${cbean.id}" method="POST" modelAttribute="cbean" class="form">
	<h2>Edit Category</h2>
	 <input type="hidden" name="id" value="${cbean.id}" />
		<label> Category Name:  </label>
		<form:input path="c_name" type="text" class="form-control" placeholder="Enter Category Name"></form:input>
		<br>
		 <form:errors path="c_name" cssClass="error" />
			
		<input type="submit" class="btn btn-primary" value="Update Category">
		 <a href="${pageContext.request.contextPath}/productAdmin" class="text-primary-emphasis">Home</a>
	</form:form>
	</div>
</body>
</html>