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
    <title>Add Item Has Type</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style type="text/css">
        body {
            background-image: url('${pageContext.request.contextPath}/resources/img/p8bg.jpg');
            background-size: cover;
            background-attachment: fixed;
            margin: 0;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: inherit;
            filter: blur(8px);
            z-index: -1;
        }

        .container {
            max-width: 500px;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1.5s ease;
            margin-top: 120px; /* Space below the navbar */
            position: relative;
            z-index: 1;
        }

        .navbar {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 2;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .error {
            color: red;
        }

        .ierror {
            color: green;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        
        .navbar-nav .nav-link {
           
            border-radius: 10px;
            background:#eee;
            margin-right: 20px;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: #ff6f61 !important;
           
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg bg-body-tertiary"  style="opacity: 0.8;">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Chef's Market</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="gohome">Home</a>
                </li>
                <li class="nav-item">
                <a href="addcategory" class="nav-link">Add Category</a>
                    
                </li>
                <li class="nav-item">
                <a href="showaddtype" class="nav-link">Add Type</a>
                   
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="showadditems">Add Item</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="productForm">Add Product</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Form Container -->
<div class="container">
    <h2>Add Item Has Type</h2>

    <c:if test="${not empty successMessage}">
        <script>
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: '${successMessage}',
                showConfirmButton: true,
                timer: 20000000
            });
        </script>
    </c:if>

    <form:form method="post" modelAttribute="command" action="${pageContext.request.contextPath}/addItemHasType">
        <div class="row mb-3">
            <div class="col-12">
                <label for="categorySelect" class="form-label">Select Category</label>
                <form:select path="c_id" id="categorySelect" class="form-select" onchange="this.form.submit()">
                    <option value="">Select Category</option>
                    <c:forEach var="cbean" items="${cbeans}">
                        <option value="${cbean.id}" <c:if test="${cbean.id == command.c_id}">selected</c:if>>${cbean.c_name}</option>
                    </c:forEach>
                </form:select>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-12">
                <label for="typeSelect" class="form-label">Select Type</label>
                <form:select path="t_id" id="typeSelect" class="form-select" onchange="this.form.submit()">
                    <option value="">Select Type</option>
                    <c:forEach var="tbean" items="${tbeans}">
                        <option value="${tbean.id}" <c:if test="${tbean.id == command.t_id}">selected</c:if>>${tbean.t_name}</option>
                    </c:forEach>
                </form:select>
                <form:errors path="t_id" cssClass="error" />
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-12">
                <label for="itemSelect" class="form-label">Select Item</label>
                <form:select path="i_id" id="itemSelect" class="form-select">
                    <option value="">Select Item</option>
                    <c:forEach var="item" items="${itemslist}">
                        <option value="${item.id}" <c:if test="${item.id == command.i_id}">selected</c:if>>${item.i_name}</option>
                    </c:forEach>
                </form:select>
                <form:errors path="i_id" cssClass="ierror" />
            </div>
        </div>

        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary">Add Item Has Type</button>
  
        </div>
    </form:form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
