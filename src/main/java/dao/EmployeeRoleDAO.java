package dao;

import model.EmployeeRole;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeRoleDAO {

    // Assigner un rôle à un employé
    public boolean assignRole(EmployeeRole employeeRole) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO الموظفونالأدوار (معرفالموظف, معرفالدور, تاريخالتعيين) VALUES (?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, employeeRole.getMعرفالموظف());
            pstmt.setInt(2, employeeRole.getMعرفالدور());
            pstmt.setDate(3, employeeRole.getتاريخالتعيين());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Récupérer toutes les assignations de rôles
    public List<EmployeeRole> getAllEmployeeRoles() {
        List<EmployeeRole> employeeRoles = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT er.*, e.الاسم AS اسمالموظف, r.اسمالدور " +
                "FROM الموظفونالأدوار er " +
                "JOIN الموظفون e ON er.معرفالموظف = e.معرفالموظف " +
                "JOIN الأدوار r ON er.معرفالدور = r.معرف_الدور " +
                "ORDER BY er.تاريخالتعيين DESC";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                EmployeeRole employeeRole = new EmployeeRole();
                employeeRole.setMعرفالموظف(rs.getInt("معرفالموظف"));
                employeeRole.setMعرفالدور(rs.getInt("معرفالدور"));
                employeeRole.setتاريخالتعيين(rs.getDate("تاريخالتعيين"));
                employeeRole.setاسمالموظف(rs.getString("اسمالموظف"));
                employeeRole.setاسمالدور(rs.getString("اسمالدور"));

                employeeRoles.add(employeeRole);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return employeeRoles;
    }

    // Récupérer les rôles d'un employé spécifique
    public List<EmployeeRole> getRolesByEmployeeId(int employeeId) {
        List<EmployeeRole> employeeRoles = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT er.*, r.اسمالدور " +
                "FROM الموظفونالأدوار er " +
                "JOIN الأدوار r ON er.معرفالدور = r.معرف_الدور " +
                "WHERE er.معرفالموظف = ? " +
                "ORDER BY er.تاريخالتعيين DESC";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, employeeId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    EmployeeRole employeeRole = new EmployeeRole();
                    employeeRole.setMعرفالموظف(rs.getInt("معرفالموظف"));
                    employeeRole.setMعرفالدور(rs.getInt("معرفالدور"));
                    employeeRole.setتاريخالتعيين(rs.getDate("تاريخالتعيين"));
                    employeeRole.setاسمالدور(rs.getString("اسمالدور"));

                    employeeRoles.add(employeeRole);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return employeeRoles;
    }

    // Récupérer les employés ayant un rôle spécifique
    public List<EmployeeRole> getEmployeesByRoleId(int roleId) {
        List<EmployeeRole> employeeRoles = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT er.*, e.الاسم AS اسمالموظف " +
                "FROM الموظفونالأدوار er " +
                "JOIN الموظفون e ON er.معرفالموظف = e.معرفالموظف " +
                "WHERE er.معرفالدور = ? " +
                "ORDER BY er.تاريخالتعيين DESC";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, roleId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    EmployeeRole employeeRole = new EmployeeRole();
                    employeeRole.setMعرفالموظف(rs.getInt("معرفالموظف"));
                    employeeRole.setMعرفالدور(rs.getInt("معرفالدور"));
                    employeeRole.setتاريخالتعيين(rs.getDate("تاريخالتعيين"));
                    employeeRole.setاسمالموظف(rs.getString("اسمالموظف"));

                    employeeRoles.add(employeeRole);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return employeeRoles;
    }

    // Supprimer une assignation de rôle
    public boolean removeEmployeeRole(int employeeId, int roleId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM الموظفونالأدوار WHERE معرفالموظف = ? AND معرفالدور = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, employeeId);
            pstmt.setInt(2, roleId);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}