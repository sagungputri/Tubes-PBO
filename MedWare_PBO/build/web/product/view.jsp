<%@page import="models.Product"%>
<%@page import="models.Admin"%>
<%@page import="models.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    Object userObject = userSession.getAttribute("user");
    String role = "";
    if (userObject instanceof Admin) {
        role = "admin";
    } else if (userObject instanceof User) {
        role = "user";
    } else {
        response.sendRedirect("../index.jsp");
        return;
    }

    ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");
    if (products == null) {
        products = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Dashboard Barang</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            color: #DC5858;
            font-family: Arial, sans-serif;
        }
        .card {
            border: 1px solid #DC5858;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card img {
            max-height: 400px;
            object-fit: cover;
        }
        .btn {
            margin: 5px 0;
        }
        .btn-primary {
            background-color: #DC5858;
            border-color: #DC5858;
        }
        .btn-primary:hover {
            background-color: #b24444;
            border-color: #b24444;
        }
        .btn-warning {
            background-color: #FFBF00;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 style="color: #DC5858; font-weight: bold;">Daftar Barang</h2>
            <% if ("admin".equals(role)) { %>
                <a href="<%= request.getContextPath() %>/product?menu=add" class="btn btn-success">Tambah Barang</a>
            <% } %>
        </div>

        <!-- log out -->
        <form method="POST" action="<%= request.getContextPath() %>/AuthController" class="mb-4">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="btn btn-danger">Logout</button>
        </form>

        <!-- search -->
        <form method="GET" action="<%= request.getContextPath() %>/product" class="mb-4 d-flex">
            <input type="hidden" name="menu" value="view">
            <input 
                type="text" 
                class="form-control me-2" 
                name="search" 
                value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" 
                placeholder="Cari produk..." 
                aria-label="Search">
            <button class="btn btn-primary" type="submit">Cari</button>
        </form>

        <!--all produk -->
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <%
                if (!products.isEmpty()) {
                    for (Product product : products) {
            %>
            <div class="col">
                <div class="card h-100">
                    <img src="<%= request.getContextPath() %>/uploads/<%= product.getImage() %>" class="card-img-top" alt="<%= product.getName() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getName() %></h5>
                        <p class="card-text">
                            Harga: Rp<%= String.format("%,.2f", product.getPrice()) %><br>
                            Stok: <%= product.getStock() %><br>
                            Kode: <%= product.getCode() != null ? product.getCode() : "-" %><br>
                            Kedaluwarsa:  <%= product.getExpiredDate() != null ? product.getExpiredDate().toString() : "-" %>
                        </p>
                    </div>
                    <div class="card-footer d-flex justify-content-between">
                        <!-- view details -->
                        <a href="<%= request.getContextPath() %>/product?menu=viewdetails&id=<%= product.getId() %>" class="btn btn-primary btn-sm">Lihat detail</a>
                        <% if ("admin".equals(role)) { %>
                            <div>
                                <a href="<%= request.getContextPath() %>/product?menu=edit&id=<%= product.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                                <form method="POST" action="<%= request.getContextPath() %>/product" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= product.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Apakah Anda yakin ingin menghapus produk ini?');">Hapus</button>
                                </form>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col">
                <div class="alert alert-warning text-center w-100">
                    Tidak ada produk.
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
