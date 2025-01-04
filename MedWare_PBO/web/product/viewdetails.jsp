<%@page import="models.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Detail Produk</title>
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
            max-width: 800px;
            margin: auto;
        }
        .card-header {
            background-color: #DC5858;
            color: white;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
        }
        .product-image {
            max-width: 100%;
            max-height: 300px;
            object-fit: contain;
            display: block;
            margin: 20px auto;
        }
        .table th {
            width: 30%;
            background-color: #f8f9fa;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <% 
            Product product = (Product) request.getAttribute("product");
            if (product == null) {
        %>
        <div class="alert alert-danger text-center">
            <h4>Data produk tidak ditemukan.</h4>
            <a href="product?menu=view" class="btn btn-secondary mt-3">Kembali ke Daftar Produk</a>
        </div>
        <% 
            } else { 
        %>
        <div class="card shadow">
            <div class="card-header">
                Detail Produk
            </div>
            <div class="card-body">
                <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>
                    <img src="<%= request.getContextPath() %>/uploads/<%= product.getImage() %>" class="product-image" alt="Gambar Produk">
                <% } else { %>
                    <img src="<%= request.getContextPath() %>/uploads/default.jpg" class="product-image" alt="Gambar Produk">
                <% } %>

                <table class="table table-bordered mt-4">
                    <tbody>
                        <tr>
                            <th>Nama Barang</th>
                            <td><%= product.getName() %></td>
                        </tr
                        <tr>
                            <th>Harga</th>
                            <td>Rp<%= String.format("%,.2f", product.getPrice()) %></td>
                        </tr>
                        <tr>
                            <th>Stok</th>
                            <td><%= product.getStock() %></td>
                        </tr>
                        <tr>
                            <th>Kode Barang</th>
                            <td><%= product.getCode() %></td>
                        </tr>
                        <tr>
                            <th>Komposisi</th>
                            <td><%= product.getComposition() %></td>
                        </tr>
                        <tr>
                            <th>Deskripsi</th>
                            <td><%= product.getDescription() %></td>
                        </tr>
                        <tr>
                            <th>Tanggal Kedaluwarsa</th>
                            <td><%= product.getExpiredDate() %></td>
                        </tr>
                        <tr>
                            <th>Efek Samping</th>
                            <td><%= product.getSideEffects() %></td>
                        </tr>
                    </tbody>
                </table>

                <div class="text-center mt-4">
                    <a href="product?menu=view" class="btn btn-secondary">Kembali ke Daftar Produk</a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</body>
</html>
