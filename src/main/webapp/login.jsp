<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - MovieFlix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/login.css">
    
</head>
<body>
<div class="container col-md-6 form-container">
    <h2 class="text-center mb-4">Login</h2>
    <form action="LoginServlet" method="post">
        <div class="mb-3">
            <label class="form-label">Username or Email</label>
            <input type="text" class="form-control" name="username" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" class="form-control" name="password" required>
        </div>
        <button type="submit" class="btn btn-danger w-100">Login</button>
        <p class="mt-3 text-center">Don't have an account? <a href="register.jsp" class="text-warning">Register</a></p>
    </form>
</div>
</body>
</html>
