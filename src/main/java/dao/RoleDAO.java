package dao;

import model.Role;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO {

    // Créer un nouveau rôle
    public boolean addRole(Role role) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO الأدوار (اسمالدور, وصفالدور) VALUES (?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, role.getاسمالدور());
            pstmt.setString(2, role.getوصفالدور());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Récupérer tous les rôles
    public List<Role> getAllRoles() {
        List<Role> roles = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM الأدوار ORDER BY معرف_الدور";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Role role = new Role();
                role.setMعرف_الدور(rs.getInt("معرف_الدور"));
                role.setاسمالدور(rs.getString("اسمالدور"));
                role.setوصفالدور(rs.getString("وصفالدور"));

                roles.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return roles;
    }

    // Récupérer un rôle par ID
    public Role getRoleById(int id) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM الأدوار WHERE معرف_الدور = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role();
                    role.setMعرف_الدور(rs.getInt("معرف_الدور"));
                    role.setاسمالدور(rs.getString("اسمالدور"));
                    role.setوصفالدور(rs.getString("وصفالدور"));

                    return role;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Mettre à jour les informations d'un rôle
    public boolean updateRole(Role role) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE الأدوار SET اسمالدور = ?, وصفالدور = ? WHERE معرف_الدور = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, role.getاسمالدور());
            pstmt.setString(2, role.getوصفالدور());
            pstmt.setInt(3, role.getMعرف_الدور());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Supprimer un rôle
    public boolean deleteRole(int id) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM الأدوار WHERE معرف_الدور = ?";

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