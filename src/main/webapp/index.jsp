<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html dir="rtl">
<head>
    <title>لوحة التحكم</title>
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

        .dashboard-header {
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
            height: 100%;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
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

        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--primary-color);
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

        .stats-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .stats-number {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary-color);
        }

        .stats-title {
            color: #666;
            font-size: 0.9rem;
        }

        footer {
            background-color: var(--dark-color);
            color: white;
            padding: 20px 0;
            margin-top: 50px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .card {
                margin-bottom: 20px;
            }
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/">
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

<!-- Dashboard Content -->
<div class="container">
    <!-- Welcome Header -->
    <div class="dashboard-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="mb-2">مرحبًا بكم في لوحة التحكم</h1>
                <p class="text-muted">مركز إدارة بيانات الموظفين والأدوار والصلاحيات</p>
            </div>
            <div class="col-md-4 text-md-end">
                <button class="btn btn-primary">
                    <i class="fas fa-plus me-1"></i>إضافة موظف جديد
                </button>
            </div>
        </div>
    </div>

    <!-- Stats Row -->
    <div class="row mb-4">
        <div class="col-md-3 col-sm-6">
            <div class="stats-card text-center">
                <i class="fas fa-users card-icon"></i>
                <div class="stats-number">124</div>
                <div class="stats-title">إجمالي الموظفين</div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stats-card text-center">
                <i class="fas fa-user-tag card-icon" style="color: var(--info-color);"></i>
                <div class="stats-number" style="color: var(--info-color);">15</div>
                <div class="stats-title">إجمالي الأدوار</div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stats-card text-center">
                <i class="fas fa-user-check card-icon" style="color: var(--success-color);"></i>
                <div class="stats-number" style="color: var(--success-color);">112</div>
                <div class="stats-title">الموظفين النشطين</div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stats-card text-center">
                <i class="fas fa-user-clock card-icon" style="color: var(--warning-color);"></i>
                <div class="stats-number" style="color: var(--warning-color);">12</div>
                <div class="stats-title">موظفين جدد هذا الشهر</div>
            </div>
        </div>
    </div>

    <!-- Main Functions Row -->
    <h2 class="mb-4">الوظائف الرئيسية</h2>
    <div class="row">
        <!-- Card for Roles -->
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-user-tag me-2"></i>إدارة الأدوار
                </div>
                <div class="card-body text-center">
                    <i class="fas fa-user-shield card-icon"></i>
                    <p class="card-text mb-4">إضافة، تعديل أو حذف الأدوار والصلاحيات في النظام بشكل مرن ومتكامل.</p>
                    <a href="${pageContext.request.contextPath}/roles" class="btn btn-primary">
                        <i class="fas fa-arrow-left me-1"></i>الذهاب إلى الأدوار
                    </a>
                </div>
            </div>
        </div>

        <!-- Card for Employees -->
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-user-tie me-2"></i>إدارة الموظفين
                </div>
                <div class="card-body text-center">
                    <i class="fas fa-id-card card-icon"></i>
                    <p class="card-text mb-4">إضافة، تعديل أو حذف بيانات الموظفين وتفاصيل الاتصال والمعلومات الشخصية.</p>
                    <a href="${pageContext.request.contextPath}/employees" class="btn btn-primary">
                        <i class="fas fa-arrow-left me-1"></i>الذهاب إلى الموظفين
                    </a>
                </div>
            </div>
        </div>

        <!-- Card for Employee Roles -->
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-users-cog me-2"></i>إدارة تعيين الأدوار
                </div>
                <div class="card-body text-center">
                    <i class="fas fa-user-cog card-icon"></i>
                    <p class="card-text mb-4">ربط الموظفين بالأدوار وإدارة الصلاحيات بشكل سهل ومرن لضمان سير العمل.</p>
                    <a href="${pageContext.request.contextPath}/employee_roles" class="btn btn-primary">
                        <i class="fas fa-arrow-left me-1"></i>الذهاب إلى تعيين الأدوار
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activities Section -->
    <div class="row mt-5">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-history me-2"></i>النشاطات الحديثة
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>النشاط</th>
                                <th>المستخدم</th>
                                <th>الوقت</th>
                                <th>التفاصيل</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><span class="badge bg-success">إضافة</span> موظف جديد</td>
                                <td>أحمد محمد</td>
                                <td>منذ 2 ساعة</td>
                                <td><a href="#" class="btn btn-sm btn-outline-primary">عرض</a></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-warning">تعديل</span> دور</td>
                                <td>سارة أحمد</td>
                                <td>منذ 3 ساعات</td>
                                <td><a href="#" class="btn btn-sm btn-outline-primary">عرض</a></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-info">تعيين</span> دور لموظف</td>
                                <td>محمد علي</td>
                                <td>منذ 5 ساعات</td>
                                <td><a href="#" class="btn btn-sm btn-outline-primary">عرض</a></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-danger">حذف</span> موظف</td>
                                <td>عمر خالد</td>
                                <td>منذ يوم</td>
                                <td><a href="#" class="btn btn-sm btn-outline-primary">عرض</a></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="text-center py-4 mt-5">
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