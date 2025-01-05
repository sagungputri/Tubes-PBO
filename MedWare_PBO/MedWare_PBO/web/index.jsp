<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - MedWare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffe5e5; 
            font-family: Arial, sans-serif;
            color: #DC5858; 
        }
        .login-container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }
        .login-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .login-card .illustration {
            background-color: #ffe5e5;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .login-card .illustration img {
            max-width: 100%;
            height: auto;
        }
        .login-card .form-section {
            padding: 40px;
            background-color: white;
        }
        .form-section h2 {
            color: #DC5858;
            font-weight: bold;
        }
        .btn-primary {
            background-color: #DC5858;
            border: none;
        }
        .btn-primary:hover {
            background-color: #c44e4e;
        }
        .form-floating label {
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container login-container">
        <div class="row w-100 align-items-center">
            <div class="col-lg-6">
                <div class="illustration">
                     <img src="https://github.com/adindalsr/TUBES_PBO/blob/main/fotologin.png?raw=true" alt="Login Illustration">
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card login-card">
                    <div class="form-section">
                        <h2 class="text-center mb-4">Welcome to <span style="color: #DC5858;">MedWare</span></h2>
                        <form method="POST" action="<%= request.getContextPath() %>/AuthController">
                            <input type="hidden" name="action" value="login">
                            
                            <!-- Dropdown untuk Username -->
                            <div class="form-floating mb-3">
                                <select class="form-control" name="username" required>
                                    <option value="admin">admin</option>
                                    <option value="user">user</option>
                                </select>
                                <label for="username">Select Your Role</label>
                            </div>
                            
                            <!-- Input Password -->
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" name="password" placeholder="Password" required>
                                <label>Enter your password</label>
                            </div>
                            
                            <!-- Tombol Login -->
                            <button type="submit" class="btn btn-primary w-100">Login</button>
                        </form>
                     
                        <% if (request.getParameter("error") != null) { %>
                        <div class="alert alert-danger mt-3 text-center">
                            Incorrect username or password! 
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
