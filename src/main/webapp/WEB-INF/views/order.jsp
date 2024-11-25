<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function showAlertAndSubmit() {
            const paymentMethod = document.querySelector('select[name="method"]');
            
            if (!paymentMethod.value) {
                Swal.fire({
                    title: 'Select Payment Method',
                    text: 'Please select a payment method to proceed.',
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });
                return; // Exit the function if no method is selected
            }
            
            // Show alert with SweetAlert2
            Swal.fire({
                title: 'Proceed to Payment?',
                text: 'Are you sure you want to proceed with the payment?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, proceed!'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Submit the form
                    document.getElementById('paymentForm').submit();
                }
            });
        }
    </script>
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Order Confirmation</h2>

    <!-- Message Display -->
    <c:if test="${not empty message}">
        <div class="alert alert-info">${message}</div>
    </c:if>

    <!-- Order Details -->
    <c:if test="${not empty orderList}">
        <div class="mb-3">
            <strong>Order Date:</strong> 
            <fmt:formatDate value="${orderList[0].date_time}" pattern="yyyy-MM-dd"/>
        </div>

        <!-- Products Table -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Product Name</th>
                        <th>Price (Kyats)</th>
                        <th>Quantity</th>
                        <th>Total Price (Kyats)</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Loop through orders and products -->
                    <c:forEach var="order" items="${orderList}">
                        <c:forEach var="item" items="${order.products}">
                            <tr>
                                <td>${item.p_name}</td>
                                <td>${item.p_price}</td>
                                <td>${item.p_quantity}</td>
                                <td>${item.p_price * item.p_quantity}</td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Total Amount and Address -->
        <div class="text-right mt-3">
            <h4>Total Amount: ${totalAmount} Kyats</h4>
        </div>
        <div class="mb-3">
            <strong>Delivery Address: ${sessionScope.address}</strong> 
        </div>

        <!-- Payment Form -->
        <form id="paymentForm" method="post" action="${pageContext.request.contextPath}/processPayment">

            <input type="hidden" name="pay_id" value="${orderList[0].pay_id}" />
            <div class="mb-3">
                <label for="paymentMethod">Payment Method:</label>
                <select name="method" class="form-control" required="true" >
                    <option value="" disabled selected>Select Payment Method</option>
                    <option value="K Pay">K Pay</option>
                    <option value="Wave">Wave</option>
                    <option value="PayPal">PayPal</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="amount">Amount:</label>
                <input type="number" name="amount" value="${totalAmount}" readonly class="form-control" />
            </div>
            <button type="button" class="btn btn-primary" onclick="showAlertAndSubmit()">Proceed to Payment</button>
        </form>
        
    </c:if>

    <!-- Empty Order List Warning -->
    <c:if test="${empty orderList}">
        <div class="alert alert-warning text-center">
            <strong>Your cart is empty. Please add items to proceed with the order.</strong>
        </div>
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/viewCart" class="btn btn-primary">Return to Cart</a>
        </div>
    </c:if>

</div>

</body>
</html>
