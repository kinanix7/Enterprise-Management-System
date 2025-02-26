package servlet;

import model.Employee;
import model.EmployeeRole;
import model.Role;
import util.DBConnection; // Corrected import

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

@WebServlet("/employee_roles")
public class EmployeeRolesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listEmployeeRoles(request, response);
                break;
            default:
                listEmployeeRoles(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addEmployeeRole(request, response);
                break;
            case "edit":
                updateEmployeeRole(request, response);
                break;
            case "delete":
                deleteEmployeeRole(request, response);
                break;
            case "filter":
                filterEmployeeRoles(request, response);
                break;
            default:
                listEmployeeRoles(request, response);
                break;
        }
    }

    private void listEmployeeRoles(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<EmployeeRole> employeeRoles = new ArrayList<>();
        List<Employee> employees = new ArrayList<>();
        List<Role> roles = new ArrayList<>();
        Map<String, Object> statistics = new HashMap<>();

        try (Connection conn = DBConnection.getConnection()) { // Corrected class name
            // Fetch assigned roles with employee and role information
            String sql = "SELECT er.معرفالموظف, er.معرفالدور, er.تاريخالتعيين, e.الاسم AS اسمالموظف, e.البريدالإلكتروني, r.اسمالدور " +
                    "FROM الموظفونالأدوار er " +
                    "INNER JOIN الموظفون e ON er.معرفالموظف = e.معرفالموظف " +
                    "INNER JOIN الأدوار r ON er.معرفالدور = r.معرف_الدور " +
                    "ORDER BY e.الاسم";

            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    EmployeeRole er = new EmployeeRole();
                    er.setMعرفالموظف(rs.getInt("معرفالموظف"));
                    er.setMعرفالدور(rs.getInt("معرفالدور"));
                    er.setتاريخالتعيين(rs.getDate("تاريخالتعيين"));
                    er.setاسمالموظف(rs.getString("اسمالموظف"));
                    er.setاسمالدور(rs.getString("اسمالدور"));
                    employeeRoles.add(er);
                }
            }

            // Fetch employees for the add form
            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM الموظفون ORDER BY الاسم");
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Employee employee = new Employee();
                    employee.setMعرفالموظف(rs.getInt("معرفالموظف"));
                    employee.setالاسم(rs.getString("الاسم"));
                    employee.setالبريدالإلكتروني(rs.getString("البريدالإلكتروني"));
                    employees.add(employee);
                }
            }

            // Fetch roles for the add form
            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM الأدوار ORDER BY اسمالدور");
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Role role = new Role();
                    role.setMعرف_الدور(rs.getInt("معرف_الدور"));
                    role.setاسمالدور(rs.getString("اسمالدور"));
                    role.setوصفالدور(rs.getString("وصفالدور"));
                    roles.add(role);
                }
            }

            // Calculate statistics
            calculateStatistics(conn, statistics);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "حدث خطأ في قاعدة البيانات: " + e.getMessage());
        }

        request.setAttribute("employeeRoles", employeeRoles);
        request.setAttribute("employees", employees);
        request.setAttribute("roles", roles);
        request.setAttribute("statistics", statistics);

        RequestDispatcher dispatcher = request.getRequestDispatcher("employee_roles.jsp");
        dispatcher.forward(request, response);
    }

    private void calculateStatistics(Connection conn, Map<String, Object> statistics) throws SQLException {
        // 1. Total assignments
        try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM الموظفونالأدوار");
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                statistics.put("totalAssignments", rs.getInt("total"));
            }
        }

        // 2. Assignments this month
        try (PreparedStatement stmt = conn.prepareStatement(
                "SELECT COUNT(*) AS total FROM الموظفونالأدوار " +
                        "WHERE YEAR(تاريخالتعيين) = YEAR(CURRENT_DATE) AND MONTH(تاريخالتعيين) = MONTH(CURRENT_DATE)");
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                statistics.put("currentMonthAssignments", rs.getInt("total"));
            }
        }

        // 3. Average roles per employee
        try (PreparedStatement stmt = conn.prepareStatement(
                "SELECT AVG(role_count) AS avg_roles FROM " +
                        "(SELECT معرفالموظف, COUNT(*) AS role_count FROM الموظفونالأدوار GROUP BY معرفالموظف) AS counts");
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                statistics.put("averageRolesPerEmployee", rs.getDouble("avg_roles"));
            }
        }

        // 4. Employees without roles
        try (PreparedStatement stmt = conn.prepareStatement(
                "SELECT COUNT(*) AS total FROM الموظفون e " +
                        "LEFT JOIN الموظفونالأدوار er ON e.معرفالموظف = er.معرفالموظف " +
                        "WHERE er.معرفالموظف IS NULL");
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                statistics.put("employeesWithoutRoles", rs.getInt("total"));
            }
        }

        // 5. Unassigned roles
        try (PreparedStatement stmt = conn.prepareStatement(
                "SELECT COUNT(*) AS total FROM الأدوار r " +
                        "LEFT JOIN الموظفونالأدوار er ON r.معرف_الدور = er.معرفالدور " +
                        "WHERE er.معرفالدور IS NULL");
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                statistics.put("unassignedRoles", rs.getInt("total"));
            }
        }


        // 6. Role distribution (percentages)
        Map<String, Double> roleDistribution = new HashMap<>();
        try (PreparedStatement stmt = conn.prepareStatement(
                "SELECT r.اسمالدور, COUNT(*) AS count, " +
                        "(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM الموظفونالأدوار)) AS percentage " +
                        "FROM الموظفونالأدوار er " +
                        "JOIN الأدوار r ON er.معرفالدور = r.معرف_الدور " +
                        "GROUP BY r.اسمالدور");
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                roleDistribution.put(rs.getString("اسمالدور"), rs.getDouble("percentage"));
            }
        }
        statistics.put("roleDistribution", roleDistribution);
    }

    private void addEmployeeRole(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int employeeId = Integer.parseInt(request.getParameter("employeeId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        String assignmentDateStr = request.getParameter("assignmentDate");

        try {
            // Convert date from String to java.sql.Date
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = format.parse(assignmentDateStr);
            java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());

            try (Connection conn = DBConnection.getConnection(); // Corrected class name
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO الموظفونالأدوار (معرفالموظف, معرفالدور, تاريخالتعيين) VALUES (?, ?, ?)")) {

                stmt.setInt(1, employeeId);
                stmt.setInt(2, roleId);
                stmt.setDate(3, sqlDate);

                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    request.setAttribute("successMessage", "تم إضافة تعيين الدور بنجاح");
                } else {
                    request.setAttribute("errorMessage", "فشل في إضافة تعيين الدور");
                }
            }
        } catch (SQLException | ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "حدث خطأ: " + e.getMessage());
        }

        // Redirect to the list
        listEmployeeRoles(request, response);
    }

    private void updateEmployeeRole(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int employeeId = Integer.parseInt(request.getParameter("employeeId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        String assignmentDateStr = request.getParameter("assignmentDate");

        try {
            // Convert date from String to java.sql.Date
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = format.parse(assignmentDateStr);
            java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());

            try (Connection conn = DBConnection.getConnection(); // Corrected class name
                 PreparedStatement stmt = conn.prepareStatement(
                         "UPDATE الموظفونالأدوار SET تاريخالتعيين = ? WHERE معرفالموظف = ? AND معرفالدور = ?")) {

                stmt.setDate(1, sqlDate);
                stmt.setInt(2, employeeId);
                stmt.setInt(3, roleId);

                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    request.setAttribute("successMessage", "تم تحديث تعيين الدور بنجاح");
                } else {
                    request.setAttribute("errorMessage", "فشل في تحديث تعيين الدور");
                }
            }
        } catch (SQLException | ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "حدث خطأ: " + e.getMessage());
        }

        // Redirect to the list
        listEmployeeRoles(request, response);
    }

    private void deleteEmployeeRole(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int employeeId = Integer.parseInt(request.getParameter("employeeId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));

        try (Connection conn = DBConnection.getConnection(); // Corrected class name
             PreparedStatement stmt = conn.prepareStatement(
                     "DELETE FROM الموظفونالأدوار WHERE معرفالموظف = ? AND معرفالدور = ?")) {

            stmt.setInt(1, employeeId);
            stmt.setInt(2, roleId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("successMessage", "تم حذف تعيين الدور بنجاح");
            } else {
                request.setAttribute("errorMessage", "فشل في حذف تعيين الدور");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "حدث خطأ: " + e.getMessage());
        }

        // Redirect to the list
        listEmployeeRoles(request, response);
    }

    private void filterEmployeeRoles(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeIdStr = request.getParameter("employeeId");
        String roleIdStr = request.getParameter("roleId");
        String assignmentDateStr = request.getParameter("assignmentDate");

        List<EmployeeRole> employeeRoles = new ArrayList<>();

        StringBuilder sqlBuilder = new StringBuilder(
                "SELECT er.معرفالموظف, er.معرفالدور, er.تاريخالتعيين, e.الاسم AS اسمالموظف, e.البريدالإلكتروني, r.اسمالدور " +
                        "FROM الموظفونالأدوار er " +
                        "INNER JOIN الموظفون e ON er.معرفالموظف = e.معرفالموظف " +
                        "INNER JOIN الأدوار r ON er.معرفالدور = r.معرف_الدور WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (employeeIdStr != null && !employeeIdStr.isEmpty()) {
            sqlBuilder.append(" AND er.معرفالموظف = ?");
            params.add(Integer.parseInt(employeeIdStr));
        }

        if (roleIdStr != null && !roleIdStr.isEmpty()) {
            sqlBuilder.append(" AND er.معرفالدور = ?");
            params.add(Integer.parseInt(roleIdStr));
        }

        if (assignmentDateStr != null && !assignmentDateStr.isEmpty()) {
            sqlBuilder.append(" AND er.تاريخالتعيين = ?");
            try {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedDate = format.parse(assignmentDateStr);
                params.add(new java.sql.Date(parsedDate.getTime()));
            } catch (ParseException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "تنسيق التاريخ غير صالح");
            }
        }

        sqlBuilder.append(" ORDER BY e.الاسم");

        try (Connection conn = DBConnection.getConnection(); // Corrected class name
             PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof Integer) {
                    stmt.setInt(i + 1, (Integer) param);
                } else if (param instanceof Date) {
                    stmt.setDate(i + 1, (java.sql.Date) param);
                }
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    EmployeeRole er = new EmployeeRole();
                    er.setMعرفالموظف(rs.getInt("معرفالموظف"));
                    er.setMعرفالدور(rs.getInt("معرفالدور"));
                    er.setتاريخالتعيين(rs.getDate("تاريخالتعيين"));
                    er.setاسمالموظف(rs.getString("اسمالموظف"));
                    er.setاسمالدور(rs.getString("اسمالدور"));
                    employeeRoles.add(er);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "حدث خطأ في قاعدة البيانات: " + e.getMessage());
        }

        // Get employees and roles lists for the form
        List<Employee> employees = new ArrayList<>();
        List<Role> roles = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) { // Corrected class name
            // Get employees
            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM الموظفون ORDER BY الاسم");
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Employee employee = new Employee();
                    employee.setMعرفالموظف(rs.getInt("معرفالموظف"));
                    employee.setالاسم(rs.getString("الاسم"));
                    employee.setالبريدالإلكتروني(rs.getString("البريدالإلكتروني"));
                    employees.add(employee);
                }
            }

            // Get roles
            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM الأدوار ORDER BY اسمالدور");
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Role role = new Role();
                    role.setMعرف_الدور(rs.getInt("معرف_الدور"));
                    role.setاسمالدور(rs.getString("اسمالدور"));
                    role.setوصفالدور(rs.getString("وصفالدور"));
                    roles.add(role);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("employeeRoles", employeeRoles);
        request.setAttribute("employees", employees);
        request.setAttribute("roles", roles);
        request.setAttribute("filterEmployeeId", employeeIdStr);
        request.setAttribute("filterRoleId", roleIdStr);
        request.setAttribute("filterAssignmentDate", assignmentDateStr);

        RequestDispatcher dispatcher = request.getRequestDispatcher("employee_roles.jsp");
        dispatcher.forward(request, response);
    }
}