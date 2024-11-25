<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
</head>
<body>
    <h2>Reset Password</h2>
    <form action="/SpringMVCProject/reset-password" method="post">
        <input type="hidden" name="token" value="${token}" /> <!-- Token passed via URL -->
        
        <label for="password">New Password:</label>
        <input type="password" name="password" id="password" required />
        <br><br>

        <input type="submit" value="Reset Password" />
    </form>
</body>
</html>