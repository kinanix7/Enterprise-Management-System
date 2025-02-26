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
    <title>إدارة تعيين الأدوار</title>
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

        .card-body {
            padding: 25px;
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

        .btn-success {
            background-color: var(--success-color);
            border-color: var(--success-color);
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .btn-success:hover {
            background-color: #43a047;
            border-color: #43a047;
            transform: scale(1.05);
        }

        .btn-danger {
            background-color: #f44336;
            border-color: #f44336;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .btn-danger:hover {
            background-color: #d32f2f;
            border-color: #d32f2f;
            transform: scale(1.05);
        }

        .table-container {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .table th {
            background-color: #f0f0f0;
        }

        .role-badge {
            background-color: var(--primary-color);
            color: white;
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            display: inline-block;
            margin: 2px;
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

        .form-select {
            border-radius: 10px;
            padding: 10px 15px;
        }

        /* Modal custom styles */
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

        .modal-title {
            font-weight: bold;
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/employees">
                        <i class="fas fa-user-tie me-1"></i>إدارة الموظفين
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/employee_roles">
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
    <!-- Header -->
    <div class="page-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="mb-2">إدارة تعيين الأدوار للموظفين</h1>
                <p class="text-muted">تخصيص الأدوار والصلاحيات للموظفين بشكل سهل ومرن</p>
            </div>
            <div class="col-md-4 text-md-end">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addRoleAssignmentModal">
                    <i class="fas fa-plus me-1"></i>تعيين دور جديد
                </button>
            </div>
        </div>
    </div>

    <!-- Filter Card -->
    <div class="card mb-4">
        <div class="card-header">
            <i class="fas fa-filter me-2"></i>تصفية النتائج
        </div>
        <div class="card-body">
            <form class="row g-3">
                <div class="col-md-4">
                    <label for="employeeFilter" class="form-label">الموظف</label>
                    <select class="form-select" id="employeeFilter">
                        <option value="" selected>جميع الموظفين</option>
                        <option value="1">أحمد محمد</option>
                        <option value="2">سارة أحمد</option>
                        <option value="3">محمد علي</option>
                        <option value="4">نورا حسن</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="roleFilter" class="form-label">الدور</label>
                    <select class="form-select" id="roleFilter">
                        <option value="" selected>جميع الأدوار</option>
                        <option value="1">مدير</option>
                        <option value="2">مشرف</option>
                        <option value="3">موظف</option>
                        <option value="4">مطور</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="dateFilter" class="form-label">تاريخ التعيين</label>
                    <input type="date" class="form-control" id="dateFilter">
                </div>
                <div class="col-12 mt-4">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="fas fa-search me-1"></i>بحث
                    </button>
                    <button type="reset" class="btn btn-outline-secondary">
                        <i class="fas fa-redo me-1"></i>إعادة تعيين
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Role Assignments Table -->
    <div class="table-container">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3>تعيينات الأدوار الحالية</h3>
            <div>
                <button class="btn btn-outline-primary me-2">
                    <i class="fas fa-download me-1"></i>تصدير Excel
                </button>
                <button class="btn btn-outline-primary">
                    <i class="fas fa-print me-1"></i>طباعة
                </button>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>#</th>
                    <th>الموظف</th>
                    <th>البريد الإلكتروني</th>
                    <th>الدور</th>
                    <th>تاريخ التعيين</th>
                    <th>الإجراءات</th>
                </tr>
                </thead>
                <tbody>
                <!-- Row 1 -->
                <tr>
                    <td>1</td>
                    <td>أحمد محمد</td>
                    <td>ahmed@example.com</td>
                    <td>
                        <span class="role-badge">مدير</span>
                    </td>
                    <td>01/01/2023</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#editRoleAssignmentModal">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleAssignmentModal">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
                <!-- Row 2 -->
                <tr>
                    <td>2</td>
                    <td>سارة أحمد</td>
                    <td>sara@example.com</td>
                    <td>
                        <span class="role-badge">مشرف</span>
                    </td>
                    <td>15/02/2023</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#editRoleAssignmentModal">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleAssignmentModal">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
                <!-- Row 3 -->
                <tr>
                    <td>3</td>
                    <td>محمد علي</td>
                    <td>mohamed@example.com</td>
                    <td>
                        <span class="role-badge">مطور</span>
                    </td>
                    <td>03/03/2023</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#editRoleAssignmentModal">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleAssignmentModal">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
                <!-- Row 4 -->
                <tr>
                    <td>4</td>
                    <td>نورا حسن</td>
                    <td>noura@example.com</td>
                    <td>
                        <span class="role-badge">مطور</span>
                        <span class="role-badge">موظف</span>
                    </td>
                    <td>10/04/2023</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#editRoleAssignmentModal">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleAssignmentModal">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
                <!-- Row 5 -->
                <tr>
                    <td>5</td>
                    <td>خالد محمود</td>
                    <td>khaled@example.com</td>
                    <td>
                        <span class="role-badge">موظف</span>
                    </td>
                    <td>22/05/2023</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#editRoleAssignmentModal">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteRoleAssignmentModal">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <!-- Pagination -->
        <nav aria-label="الصفحات" class="mt-4">
            <ul class="pagination justify-content-center">
                <li class="page-item disabled">
                    <a class="page-link" href="#" aria-label="السابق">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="التالي">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Employee Roles Summary Section -->
    <div class="row mt-5">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-chart-pie me-2"></i>توزيع الأدوار
                </div>
                <div class="card-body text-center">
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span>مدير</span>
                            <span>15%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar bg-primary" role="progressbar" style="width: 15%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span>مشرف</span>
                            <span>25%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span>موظف</span>
                            <span>40%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span>مطور</span>
                            <span>20%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-clipboard-list me-2"></i>إحصائيات التعيين
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            إجمالي التعيينات
                            <span class="badge bg-primary rounded-pill">25</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            تعيينات هذا الشهر
                            <span class="badge bg-success rounded-pill">8</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            متوسط الأدوار لكل موظف
                            <span class="badge bg-info rounded-pill">1.5</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            موظفين بدون أدوار
                            <span class="badge bg-warning rounded-pill">3</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            أدوار غير مخصصة
                            <span class="badge bg-danger rounded-pill">2</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modals -->

<!-- Add Role Assignment Modal -->
<div class="modal fade" id="addRoleAssignmentModal" tabindex="-1" aria-labelledby="addRoleAssignmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addRoleAssignmentModalLabel">تعيين دور جديد</h5>
                <button type="button" class="btn-close ms-0 me-auto" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="employeeSelect" class="form-label">الموظف</label>
                        <select class="form-select" id="employeeSelect" required>
                            <option value="" selected disabled>اختر الموظف</option>
                            <option value="1">أحمد محمد</option>
                            <option value="2">سارة أحمد</option>
                            <option value="3">محمد علي</option>
                            <option value="4">نورا حسن</option>
                            <option value="5">خالد محمود</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="roleSelect" class="form-label">الدور</label>
                        <select class="form-select" id="roleSelect" required>
                            <option value="" selected disabled>اختر الدور</option>
                            <option value="1">مدير</option>
                            <option value="2">مشرف</option>
                            <option value="3">موظف</option>
                            <option value="4">مطور</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="assignmentDate" class="form-label">تاريخ التعيين</label>
                        <input type="date" class="form-control" id="assignmentDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="assignmentNotes" class="form-label">ملاحظات</label>
                        <textarea class="form-control" id="assignmentNotes" rows="3"></textarea>
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

<!-- Edit Role Assignment Modal -->
<div class="modal fade" id="editRoleAssignmentModal" tabindex="-1" aria-labelledby="editRoleAssignmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editRoleAssignmentModalLabel">تعديل تعيين الدور</h5>
                <button type="button" class="btn-close ms-0 me-auto" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="editEmployeeSelect" class="form-label">الموظف</label>
                        <select class="form-select" id="editEmployeeSelect" required disabled>
                            <option value="1">أحمد محمد</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editRoleSelect" class="form-label">الدور</label>
                        <select class="form-select" id="editRoleSelect" required>
                            <option value="1" selected>مدير</option>
                            <option value="2">مشرف</option>
                            <option value="3">موظف</option>
                            <option value="4">مطور</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editAssignmentDate" class="form-label">تاريخ التعيين</label>
                        <input type="date" class="form-control" id="editAssignmentDate" value="2023-01-01" required>
                    </div>
                    <div class="mb-3">
                        <label for="editAssignmentNotes" class="form-label">ملاحظات</label>
                        <textarea class="form-control" id="editAssignmentNotes" rows="3">ملاحظات تعيين سابقة</textarea>
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

<!-- Delete Role Assignment Modal -->
<div class="modal fade" id="deleteRoleAssignmentModal" tabindex="-1" aria-labelledby="deleteRoleAssignmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteRoleAssignmentModalLabel">تأكيد الحذف</h5>
                <button type="button" class="btn-close ms-0 me-auto" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>هل أنت متأكد من رغبتك في حذف تعيين الدور "مدير" للموظف "أحمد محمد"؟</p>
                <p class="text-danger">لا يمكن التراجع عن هذا الإجراء.</p>
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
                <p class="small">الدعم الفني: support@example.com</p>
                <p class="small">هاتف: 123-456-7890</p>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>