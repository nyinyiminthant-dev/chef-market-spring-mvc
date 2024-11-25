<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Has Type List</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

    <div class="container mt-4">
        <h1>Item Has Type List</h1>
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th scope="col">No</th>
                    <th scope="col">Category</th>
                    <th scope="col">Type</th>
                    <th scope="col">Item</th>
                    <th scope="col">Add Ingredient</th>
                </tr>
            </thead>
           <tbody>
    <c:forEach var="ihtlist" items="${itemhastypelist}" varStatus="count">
        <tr>
            <td>${count.count}</td>
            <td>${ihtlist.c_name}</td>
            <td>${ihtlist.t_name}</td>
            <td>${ihtlist.i_name}</td>
            <td>
                <a href="edit/${ihtlist.id}" class="btn btn-success">Add</a>
            </td>
        </tr>
    </c:forEach>
</tbody>

        </table>
       
    </div>

</body>
</html>
