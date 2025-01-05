<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Tambah Barang</title>
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
        .card-header {
            background-color: #DC5858;
            color: white;
        }
        .btn-primary {
            background-color: #DC5858;
            border-color: #DC5858;
        }
        .btn-primary:hover {
            background-color: #b24444;
            border-color: #b24444;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #5a6268;
        }
        .form-control {
            border: 1px solid #DC5858;
        }
        .form-control:focus {
            border-color: #b24444;
            box-shadow: 0 0 0 0.25rem rgba(220, 88, 88, 0.25);
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <div class="card shadow">
            <div class="card-header text-center">
                <h2>Tambah Barang</h2>
            </div>
            <div class="card-body">
                <form method="POST" action="product" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="add">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="nama" placeholder="Nama Barang" required>
                        <label>Nama Barang</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" step="0.01" class="form-control" name="harga" placeholder="Harga Barang" required>
                        <label>Harga Barang</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="number" class="form-control" name="stok" placeholder="Stok" required>
                        <label>Stok</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="kode" placeholder="Kode Barang" required>
                        <label>Kode Barang</label>
                    </div>
                    <div class="form-floating mb-3">
                        <textarea class="form-control" name="komposisi" placeholder="Komposisi Barang" rows="3"></textarea>
                        <label>Komposisi Barang</label>
                    </div>
                    <div class="form-floating mb-3">
                        <textarea class="form-control" name="deskripsi" placeholder="Deskripsi Barang" rows="3"></textarea>
                        <label>Deskripsi Barang</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="file" class="form-control" name="image" accept="image/*" required>
                        <label>Upload Gambar</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="date" class="form-control" name="expiredDate" placeholder="Tanggal Kedaluwarsa" required>
                        <label>Tanggal Kedaluwarsa</label>
                    </div>
                    <div class="form-floating mb-3">
                        <textarea class="form-control" name="sideEffects" placeholder="Efek Samping" rows="3"></textarea>
                        <label>Efek Samping</label>
                    </div>


                    <button type="submit" class="btn btn-primary w-100">Simpan</button>
                </form>
                <div class="mt-3 text-center">
                    <a href="product?menu=view" class="btn btn-secondary">Kembali ke Daftar Barang</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
