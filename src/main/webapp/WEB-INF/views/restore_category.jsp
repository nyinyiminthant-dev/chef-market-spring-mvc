<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
</head>
<body>

 <h1> Restore Category List</h1>
 <a href="productAdmin">Category List</a>
		<table class="table table-striped table-hover">
  <thead>
    <tr>

      <th scope="col">Id</th>
      <th scope="col">Name</th>
    <th scope="col">Action</th>
      
    </tr>
  </thead>
  <tbody>
  <c:forEach var="cbean" items="${recategory}" varStatus="count">
      <tr>
       <td>${count.count} </td>
        <td>${cbean.c_name}</td>
        <td>
                <a href="restore/${cbean.id}" class="btn btn-success">Restore</a>
            </td>
      </tr>
       
    </c:forEach>
  </tbody>
</table>
 

</body>
</html>