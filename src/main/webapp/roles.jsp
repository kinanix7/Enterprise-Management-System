<%--
  Created by IntelliJ IDEA.
  User: youne
  Date: 2/25/2025
  Time: 3:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html dir="rtl">
<head>
    <title>إدارة الأدوار</title>
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

        .table-actions .btn {
            margin: 0 2px;
        }

        footer {
            background-color: var(--dark-color);
            color: white;
            padding: 20px 0;
            margin-top: 50px;
        }

        .form-control {
            padding: 12px;
            border-radius: 8px;
        }

        .form-label {
            font-weight: 500;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/roles">
                        <i class="fas fa-user-tag me-1"></i>إدارة الأدوار
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/employees">
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

<!-- Page Content -->
<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="mb-2">إدارة الأدوار</h1>
                <p class="text-muted">إضافة، تعديل، وحذف الأدوار والصلاحيات في النظام</p>
            </div>
            <div class="col-md-4 text-md-end">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addRoleModal">
                    <i class="fas fa-plus me-1"></i>إضافة دور جديد
                </button>
            </div>
        </div>
    </div>

    <!-- Search and Filter -->
    <div class="card mb-4">
        <div class="card-header">
            <i class="fas fa-search me-2"></i>بحث وتصفية
        </div>
        <div class="card-body">
            <form>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="searchRole" class="form-label">البحث بالاسم</label>
                        <input type="text" class="form-control" id="searchRole" placeholder="اكتب اسم الدور...">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="sortBy" class="form-label">ترتيب حسب</label>
                        <select class="form-select" id="sortBy">
                            <option value="name">الاسم</option>
                            <option value="description">الوصف</option>
                            <option value="date">تاريخ الإنشاء</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end mb-3">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search me-1"></i>بحث
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Roles Table -->
    <div class="card">
        <div class="card-header">
            <i class="fas fa-user-tag me-2"></i>قائمة الأدوار
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>معرف الدور</th>
                        <th>اسم الدور</th>
                        <th>وصف الدور</th>
                        <th>عدد الموظفين</th>
                        <th>العمليات</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>مدير</td>
                        <td>المسؤول عن إدارة النظام بالكامل وله كل الصلاحيات</td>
                        <td><span class="badge bg-primary">12</span></td>
                        <td class="table-actions">
                            <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#editRoleModal">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleModal">
                                <i class="fas fa-trash"></i>
                            </button>
                            <button class="btn btn-sm btn-secondary">
                                <i class="fas fa-eye"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>مدير موارد بشرية</td>
                        <td>المسؤول عن إدارة شؤون الموظفين والتوظيف</td>
                        <td><span class="badge bg-primary">15</span></td>
                        <td class="table-actions">
                            <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#editRoleModal">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleModal">
                                <i class="fas fa-trash"></i>
                            </button>
                            <button class="btn btn-sm btn-secondary">
                                <i class="fas fa-eye"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>محاسب</td>
                        <td>المسؤول عن إدارة الحسابات والمالية</td>
                        <td><span class="badge bg-primary">8</span></td>
                        <td class="table-actions">
                            <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#editRoleModal">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleModal">
                                <i class="fas fa-trash"></i>
                            </button>
                            <button class="btn btn-sm btn-secondary">
                                <i class="fas fa-eye"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>مسؤول تقنية</td>
                        <td>المسؤول عن الدعم الفني وإدارة أنظمة المعلومات</td>
                        <td><span class="badge bg-primary">5</span></td>
                        <td class="table-actions">
                            <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#editRoleModal">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleModal">
                                <i class="fas fa-trash"></i>
                            </button>
                            <button class="btn btn-sm btn-secondary">
                                <i class="fas fa-eye"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>موظف</td>
                        <td>موظف عادي بصلاحيات محدودة</td>
                        <td><span class="badge bg-primary">84</span></td>
                        <td class="table-actions">
                            <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#editRoleModal">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleModal">
                                <i class="fas fa-trash"></i>
                            </button>
                            <button class="btn btn-sm btn-secondary">
                                <i class="fas fa-eye"></i>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1" aria-disabled="true">السابق</a>
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

<!-- Add Role Modal -->
<div class="modal fade" id="addRoleModal" tabindex="-1" aria-labelledby="addRoleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addRoleModalLabel">إضافة دور جديد</h5>
                <button type="button" class="btn-close ms-0 me-2" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="roleName" class="form-label">اسم الدور</label>
                        <input type="text" class="form-control" id="roleName" placeholder="أدخل اسم الدور" required>
                    </div>
                    <div class="mb-3">
                        <label for="roleDescription" class="form-label">وصف الدور</label>
                        <textarea class="form-control" id="roleDescription" rows="3" placeholder="أدخل وصف الدور"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label d-block">الصلاحيات</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="viewPermission" value="view">
                            <label class="form-check-label" for="viewPermission">عرض</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="addPermission" value="add">
                            <label class="form-check-label" for="addPermission">إضافة</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="editPermission" value="edit">
                            <label class="form-check-label" for="editPermission">تعديل</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="deletePermission" value="delete">
                            <label class="form-check-label" for="deletePermission">حذف</label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">إلغاء</button>
                <button type="button" class="btn btn-primary">حفظ</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Role Modal -->
<div class="modal fade" id="editRoleModal" tabindex="-1" aria-labelledby="editRoleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editRoleModalLabel">تعديل الدور</h5>
                <button type="button" class="btn-close ms-0 me-2" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="editRoleName" class="form-label">اسم الدور</label>
                        <input type="text" class="form-control" id="editRoleName" value="مدير" required>
                    </div>
                    <div class="mb-3">
                        <label for="editRoleDescription" class="form-label">وصف الدور</label>
                        <textarea class="form-control" id="editRoleDescription" rows="3">المسؤول عن إدارة النظام بالكامل وله كل الصلاحيات</textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label d-block">الصلاحيات</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="editViewPermission" value="view" checked>
                            <label class="form-check-label" for="editViewPermission">عرض</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="editAddPermission" value="add" checked>
                            <label class="form-check-label" for="editAddPermission">إضافة</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="editEditPermission" value="edit" checked>
                            <label class="form-check-label" for="editEditPermission">تعديل</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="editDeletePermission" value="delete" checked>
                            <label class="form-check-label" for="editDeletePermission">حذف</label>
                        </div>
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

<!-- Delete Role Modal -->
<div class="modal fade" id="deleteRoleModal" tabindex="-1" aria-labelledby="deleteRoleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteRoleModalLabel">حذف دور</h5>
                <button type="button" class="btn-close ms-0 me-2" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>هل أنت متأكد من رغبتك في حذف هذا الدور؟ هذا الإجراء لا يمكن التراجع عنه.</p>
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    تحذير: سيتم إزالة هذا الدور من جميع الموظفين المرتبطين به.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">إلغاء</button>
                <button type="button" class="btn btn-danger">تأكيد الحذف</button>
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
                <p class="small">الدعم الفني: kinani@example.com</p>
                <p class="small">هاتف: 123-456-7890</p>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>