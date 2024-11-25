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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Ingredient</title>
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Add Custom CSS for Animation, Background Image, and Enhanced Blur Effect -->
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
           
        }
        /* Background Image */
        .background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('${pageContext.request.contextPath}/resources/img/p1bg.jpg');
            background-size: cover;
            background-position: center;
            z-index: -2;
        }
        /* Blur Overlay */
        .blur-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            backdrop-filter: blur(15px); /* Increased blur */
            -webkit-backdrop-filter: blur(15px); /* Increased blur for Safari */
            z-index: -1;
        }
        /* Container Styling */
        .container {
            background: rgba(255, 255, 255, 0.85);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.2);
            margin-top: 60px;
            animation: slideIn 1s ease-in-out;
        }
        h2 {
            color: #000;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
        }
        label {
            font-weight: bold;
        }
        .form-control {
            border-radius: 8px;
            transition: box-shadow 0.3s ease;
        }
        .form-control:hover, .form-control:focus {
            box-shadow: 0 0 10px #4e73df;
            border-color: #4e73df;
        }
        .btn-primary {
            background-color: #4e73df;
            border: none;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-primary:hover {
            background-color: #375a7f;
            transform: scale(1.05);
        }
        @keyframes slideIn {
            0% { opacity: 0; transform: translateY(50px); }
            100% { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>








    <!-- Background Image -->
    <div class="background"></div>
    <!-- Blur Overlay -->
    <div class="blur-overlay"></div>

   <div class="container">
    <h2>Add New Ingredient</h2>

    <!-- Display global error messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-danger">${message}</div>
    </c:if>
<%-- <% Integer itId = (Integer) session.getAttribute("ihtbean.id"); %> --%>
    <form:form action="${pageContext.request.contextPath}/addIngredient" method="post" modelAttribute="ingredientObj" enctype="multipart/form-data" class="form">
        <a href="${pageContext.request.contextPath}/productAdmin" class="text-primary-emphasis">Home</a>

        <input type="text" name="it_id" value="${sessionScope.it_id }" class="form-control" readonly="readonly" style="width: 100px;" />


        <label for="item_name">Item Name</label>    
        <form:input path="item_name" type="text" class="form-control"/>
        <form:errors path="item_name" cssClass="error text-danger" />
        <br>

        <div class="form-group">
            <label for="in_name">Ingredients</label>
            <form:textarea path="in_name" rows="4" cols="50" class="form-control"></form:textarea>
            <form:errors path="in_name" cssClass="error text-danger" />
        </div>

        <div class="form-group">
            <label for="instruction">Instruction</label>
            <form:textarea path="instruction" rows="4" cols="50" class="form-control"></form:textarea>
            <form:errors path="instruction" cssClass="error text-danger" />
        </div>

        <label for="remark">Remark</label>    
        <form:input path="remark" type="text" class="form-control"/>
        <form:errors path="remark" cssClass="error text-danger" />
        <br>

        <div class="form-group">
            <label for="photo">Upload Photos</label>
            <input type="file" name="photo" class="form-control-file" multiple /> 
            <form:errors path="photo" cssClass="error text-danger" />
        </div>

        <input type="submit" class="btn btn-primary btn-block" value="Add">
    </form:form>
</div>


    <!-- Bootstrap, jQuery, and SweetAlert2 JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</body>
</html>
