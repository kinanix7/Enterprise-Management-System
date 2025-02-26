package dao;

import model.Employee;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    // Créer un nouvel employé
    public boolean addEmployee(Employee employee) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO الموظفون (الاسم, البريدالإلكتروني) VALUES (?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, employee.getالاسم());
            pstmt.setString(2, employee.getالبريدالإلكتروني());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Récupérer tous les employés
    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM الموظفون ORDER BY معرفالموظف";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Employee employee = new Employee();
                employee.setMعرفالموظف(rs.getInt("معرفالموظف"));
                employee.setالاسم(rs.getString("الاسم"));
                employee.setالبريدالإلكتروني(rs.getString("البريدالإلكتروني"));

                employees.add(employee);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return employees;
    }

    // Récupérer un employé par ID
    public Employee getEmployeeById(int id) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM الموظفون WHERE معرفالموظف = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Employee employee = new Employee();
                    employee.setMعرفالموظف(rs.getInt("معرفالموظف"));
                    employee.setالاسم(rs.getString("الاسم"));
                    employee.setالبريدالإلكتروني(rs.getString("البريدالإلكتروني"));

                    return employee;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Mettre à jour les informations d'un employé
    public boolean updateEmployee(Employee employee) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE الموظفون SET الاسم = ?, البريدالإلكتروني = ? WHERE معرفالموظف = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, employee.getالاسم());
            pstmt.setString(2, employee.getالبريدالإلكتروني());
            pstmt.setInt(3, employee.getMعرفالموظف());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Supprimer un employé
    public boolean deleteEmployee(int id) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM الموظفون WHERE معرفالموظف = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}