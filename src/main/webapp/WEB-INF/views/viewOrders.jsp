<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-light">


<c:if test="${not empty successMessage}">
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '${successMessage}',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
            
        });
    </script>
</c:if>

<div class="container my-5">
    <h2 class="text-center mb-4">Your Orders</h2>

    <!-- Display message if available -->
    <c:if test="${not empty message}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Display list of orders -->
    <c:forEach var="order" items="${orderList}">
        <div class="card mb-4 shadow-sm">
            <div class="card-body">
                
                <p class="card-text">
                    <strong>Order Date:</strong> 
                    <fmt:formatDate value="${order.date_time}" pattern="yyyy-MM-dd hh:mm a"/>
                </p>
                <p class="card-text"><strong>Shipping Address:</strong> ${sessionScope.address}</p>
                <p class="card-text"><strong>Payment :</strong> ${sessionScope.payment}</p>
                <p class="card-text"><strong>Total Price:</strong> <span class="fw-bold text-success">${order.price}</span></p>
                
                <h6 class="mt-3">Products:</h6>
                <ul class="list-group list-group-flush">
                    <c:forEach var="product" items="${order.products}">
                        <li class="list-group-item">
                            <span class="fw-bold">${product.p_name}</span> - Quantity: ${product.p_quantity}, Price: ${product.p_price}
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:forEach>

    <!-- Message for no orders found -->
    <c:if test="${empty orderList}">
        <div class="alert alert-warning text-center" role="alert">
            No orders found.
        </div>
    </c:if>

    <!-- Go to Home Page Link -->
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/backfrompayment" class="btn btn-primary">Go to Home Page</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
