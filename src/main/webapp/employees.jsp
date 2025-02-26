<%--
  Created by IntelliJ IDEA.
  User: youne
  Date: 2/25/2025
  Time: 3:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html dir="rtl">
<head>
    <title>إدارة الموظفين</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3f51b5;
            --secondary-color: #ff4081;
            --dark-color: #303030;
            --light-color: #f8f9fa;
            --success-color: #4caf50;
            --info-color: #03a9f4;
            --warning-color: #ff9800;
        }

        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background-color: var(--primary-color) !important;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
        }

        .navbar-brand, .nav-link {
            color: white !important;
        }

        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }

        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 5px;
        }

        .page-header {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card {
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .card-header {
            background-color: var(--primary-color);
            color: white;
            font-weight: bold;
            padding: 15px;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            background-color: #303f9f;
            border-color: #303f9f;
            transform: scale(1.05);
        }

        .btn-danger {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .btn-danger:hover {
            background-color: #d81b60;
            border-color: #d81b60;
            transform: scale(1.05);
        }

        table.table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 0, 0, 0.02);
        }

        .search-container {
            position: relative;
            margin-bottom: 20px;
        }

        .search-container input {
            padding-right: 40px;
            border-radius: 30px;
        }

        .search-container i {
            position: absolute;
            top: 10px;
            right: 15px;
            color: #999;
        }

        footer {
            background-color: var(--dark-color);
            color: white;
            padding: 20px 0;
            margin-top: 50px;
        }

        .form-control {
            border-radius: 10px;
            padding: 10px 15px;
        }

        /* Modal customization */
        .modal-content {
            border-radius: 15px;
            border: none;
        }

        .modal-header {
            background-color: var(--primary-color);
            color: white;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .modal-footer {
            border-top: none;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-users-cog me-2"></i>نظام إدارة الموظفين
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">
                        <i class="fas fa-home me-1"></i>الرئيسية
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/roles">
                        <i class="fas fa-user-tag me-1"></i>إدارة الأدوار
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/employees">
                        <i class="fas fa-user-tie me-1"></i>إدارة الموظفين
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/employee_roles">
                        <i class="fas fa-users-cog me-1"></i>إدارة تعيين الأدوار
                    </a>
                </li>
            </ul>
            <div class="d-flex">
                <a href="#" class="btn btn-outline-light rounded-circle me-2">
                    <i class="fas fa-bell"></i>
                </a>
                <a href="#" class="btn btn-outline-light rounded-circle">
                    <i class="fas fa-user"></i>
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Content -->
<div class="container">
    <!-- Header -->
    <div class="page-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="mb-2">إدارة الموظفين</h1>
                <p class="text-muted">إضافة، تعديل وإزالة الموظفين في النظام</p>
            </div>
            <div class="col-md-4 text-md-end">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addEmployeeModal">
                    <i class="fas fa-plus me-1"></i>إضافة موظف جديد
                </button>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="card">
        <div class="card-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <i class="fas fa-user-tie me-2"></i>قائمة الموظفين
                </div>
                <div class="col-md-4">
                    <div class="search-container">
                        <input type="text" class="form-control" placeholder="بحث...">
                        <i class="fas fa-search"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>معرف الموظف</th>
                        <th>الاسم</th>
                        <th>البريد الإلكتروني</th>
                        <th>الإجراءات</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>أحمد محمد</td>
                        <td>ahmed@example.com</td>
                        <td>
                            <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">
                                <i class="fas fa-edit"></i> تعديل
                            </button>
                            <button class="btn btn-sm btn-danger">
                                <i class="fas fa-trash"></i> حذف
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>سارة أحمد</td>
                        <td>sara@example.com</td>
                        <td>
                            <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">
                                <i class="fas fa-edit"></i> تعديل
                            </button>
                            <button class="btn btn-sm btn-danger">
                                <i class="fas fa-trash"></i> حذف
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>محمد علي</td>
                        <td>mohamed@example.com</td>
                        <td>
                            <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">
                                <i class="fas fa-edit"></i> تعديل
                            </button>
                            <button class="btn btn-sm btn-danger">
                                <i class="fas fa-trash"></i> حذف
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>فاطمة خالد</td>
                        <td>fatima@example.com</td>
                        <td>
                            <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">
                                <i class="fas fa-edit"></i> تعديل
                            </button>
                            <button class="btn btn-sm btn-danger">
                                <i class="fas fa-trash"></i> حذف
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>عمر حسن</td>
                        <td>omar@example.com</td>
                        <td>
                            <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">
                                <i class="fas fa-edit"></i> تعديل
                            </button>
                            <button class="btn btn-sm btn-danger">
                                <i class="fas fa-trash"></i> حذف
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center mt-4">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1">السابق</a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#">التالي</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<!-- Add Employee Modal -->
<div class="modal fade" id="addEmployeeModal" tabindex="-1" aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addEmployeeModalLabel">إضافة موظف جديد</h5>
                <button type="button" class="btn-close ms-0 me-auto" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addEmployeeForm">
                    <div class="mb-3">
                        <label for="employeeName" class="form-label">اسم الموظف</label>
                        <input type="text" class="form-control" id="employeeName" required>
                    </div>
                    <div class="mb-3">
                        <label for="employeeEmail" class="form-label">البريد الإلكتروني</label>
                        <input type="email" class="form-control" id="employeeEmail" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">إلغاء</button>
                <button type="button" class="btn btn-primary">إضافة</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Employee Modal -->
<div class="modal fade" id="editEmployeeModal" tabindex="-1" aria-labelledby="editEmployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editEmployeeModalLabel">تعديل بيانات الموظف</h5>
                <button type="button" class="btn-close ms-0 me-auto" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editEmployeeForm">
                    <input type="hidden" id="editEmployeeId" value="1">
                    <div class="mb-3">
                        <label for="editEmployeeName" class="form-label">اسم الموظف</label>
                        <input type="text" class="form-control" id="editEmployeeName" value="أحمد محمد" required>
                    </div>
                    <div class="mb-3">
                        <label for="editEmployeeEmail" class="form-label">البريد الإلكتروني</label>
                        <input type="email" class="form-control" id="editEmployeeEmail" value="ahmed@example.com" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">إلغاء</button>
                <button type="button" class="btn btn-primary">حفظ التغييرات</button>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="text-center py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-4 text-md-start">
                <h5>نظام إدارة الموظفين</h5>
                <p class="small">منصة متكاملة لإدارة شؤون الموظفين والأدوار</p>
            </div>
            <div class="col-md-4">
                <p>&copy; 2023 جميع الحقوق محفوظة</p>
                <div class="mt-2">
                    <a href="#" class="btn btn-sm btn-outline-light mx-1"><i class="fab fa-facebook"></i></a>
                    <a href="#" class="btn btn-sm btn-outline-light mx-1"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="btn btn-sm btn-outline-light mx-1"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>
            <div class="col-md-4 text-md-end">
                <p class="small">الدعم الفني: support@example.com</p>
                <p class="small">هاتف: 123-456-7890</p>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
