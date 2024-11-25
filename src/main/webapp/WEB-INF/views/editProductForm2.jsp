<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    <title>Edit Product</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/resources/img/about-3.jpg');
            background-size: cover;
            background-attachment: fixed;
            backdrop-filter: blur(8px);
        }

        .form-container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 30px;
            max-width: 600px;
            margin: 50px auto;
            animation: fadeIn 1s ease-in-out;
        }

        .error {
            color: red;
        }

        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
    </style>
    <script>
        function validateForm() {
            let isValid = true;

            const name = document.getElementById("p_name").value.trim();
            const size = document.getElementById("size").value;
            const price = document.getElementById("p_price").value.trim();
            const quantity = document.getElementById("p_quantity").value.trim();
            const photos = document.getElementById("mfphoto").files;

            const nameError = document.getElementById("nameError");
            const sizeError = document.getElementById("sizeError");
            const priceError = document.getElementById("priceError");
            const quantityError = document.getElementById("quantityError");
            const photoError = document.getElementById("photoError");

            nameError.innerHTML = "";
            sizeError.innerHTML = "";
            priceError.innerHTML = "";
            quantityError.innerHTML = "";
            photoError.innerHTML = "";

            if (name === "") {
                nameError.innerHTML = "Product name is required.";
                isValid = false;
            }
            if (size === "") {
                sizeError.innerHTML = "Please select a size.";
                isValid = false;
            }
            if (price === "") {
                priceError.innerHTML = "Price is required.";
                isValid = false;
            } else if (isNaN(price) || price <= 0) {
                priceError.innerHTML = "Price must be a positive number.";
                isValid = false;
            }
            if (quantity === "" || isNaN(quantity) || parseInt(quantity) <= 0) {
                quantityError.innerHTML = "Quantity must be a positive number greater than zero.";
                isValid = false;
            }
            if (photos.length > 0) {
                const photoErrorMessage = document.getElementById("photoError");
                photoErrorMessage.innerHTML = ""; // Clear any previous errors for photo
            }
            return isValid;
        }
    </script>
</head>
<body>
    <div class="container form-container shadow-lg">
        <h2 class="text-center mb-4">Edit Product</h2>
        <p class="text-center text-success">${message}</p>

        <form:form action="${pageContext.request.contextPath}/updateProducts" method="post" modelAttribute="product" enctype="multipart/form-data" onsubmit="return validateForm()" class="needs-validation">

            <!-- Hidden ID field to pass the product ID -->
            <form:hidden path="id" />

            <div class="form-group">
                <label for="p_name">Name:</label>
                <form:input type="text" path="p_name" required="true" id="p_name" class="form-control" />
                <span id="nameError" class="error"></span>
            </div>

            <div class="form-group">
                <label for="size">Size:</label>
                <select id="size" name="p_size" class="form-control" required>
                    <option value="">--⬇️ Please Select Size ⬇️--</option>
                    <option value="Small" <c:if test="${product.p_size == 'Small'}">selected</c:if>>Small</option>
                    <option value="Medium" <c:if test="${product.p_size == 'Medium'}">selected</c:if>>Medium</option>
                    <option value="Large" <c:if test="${product.p_size == 'Large'}">selected</c:if>>Large</option>
                </select>
                <span id="sizeError" class="error"></span>
            </div>

            <div class="form-group">
                <label for="p_price">Price:</label>
                <form:input type="number" path="p_price" required="true" id="p_price" class="form-control" />
                <span id="priceError" class="error"></span>
            </div>

            <div class="form-group">
                <label for="p_quantity">Quantity:</label>
                <form:input type="number" path="p_quantity" required="true" id="p_quantity" class="form-control" />
                <span id="quantityError" class="error"></span>
            </div>

            <form:hidden path="p_photo" />

            <div class="form-group">
                <label for="mfphoto">Upload New Photo (leave empty to keep current):</label>
                <form:input type="file" path="mfphoto" id="mfphoto" accept="image/*" class="form-control-file" />
                <span id="photoError" class="error"></span>
            </div>

            <button type="submit" class="btn btn-primary btn-block">Update</button>
            <a href="${pageContext.request.contextPath}/viewProduct" class="btn btn-secondary btn-block">Cancel</a>
        </form:form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
