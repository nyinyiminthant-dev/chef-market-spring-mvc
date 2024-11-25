<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Form</title>
   
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/resources/img/p9bg.jpg');
            background-size: cover;
            height:800px;
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
            if (photos.length === 0) {
                photoError.innerHTML = "Please upload at least one product photo.";
                isValid = false;
            }
            return isValid;
        }
    </script>
</head>
<body>


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
        <a href="showaddtype" class="nav-link" id="add">Add Type</a>
        
        </li>
        <li class="nav-item">
          <a class="nav-link" href="showadditems">Add Item</a>
          
        </li>
        <li class="nav-item">
         <a class="nav-link" href="showAddItemHasType">Add Item has type</a>
          
        </li>
        <li class="nav-item">
        <a class="nav-link" href="viewProduct">View Product</a>
        </li>
      </ul>
    </div>
  </div>
</nav>


    <div class="container form-container shadow-lg">
        <h2 class="text-center mb-4">Product Form</h2>
        <p class="text-center text-success">${message}</p>
        
        <form:form action="showProduct" method="post" modelAttribute="product" enctype="multipart/form-data" onsubmit="return validateForm()" class="needs-validation">
            <div class="form-group">
                <label for="p_name">Name:</label>
                <form:input type="text" path="p_name" id="p_name" class="form-control" />
                <span id="nameError" class="error"></span>
            </div>

            <div class="form-group">
                <label for="size">Size:</label>
                <select id="size" name="p_size" class="form-control" size="3">
                    <option value="">--⬇️ Please Select Size ⬇️--</option>
                    <option value="Small">Small</option>
                    <option value="Medium">Medium</option>
                    <option value="Large">Large</option>
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

            <div class="form-group">
                <label for="mfphoto">Upload Photos:</label>
                <form:input type="file" path="mfphoto" id="mfphoto" accept="image/*" class="form-control-file" />
                <span id="photoError" class="error"></span>
            </div>

            <button type="submit" class="btn btn-primary btn-block">Submit</button>
            <a href="viewProduct">View Product</a>
        </form:form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
