package servlet;

import dao.RoleDAO;
import model.Role;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/roles")
public class RoleServlet extends HttpServlet {
    private RoleDAO roleDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        roleDAO = new RoleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteRole(request, response);
                break;
            default:
                listRoles(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addRole(request, response);
                break;
            case "update":
                updateRole(request, response);
                break;
            default:
                listRoles(request, response);
                break;
        }
    }

    private void listRoles(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Role> roles = roleDAO.getAllRoles();
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("/roles.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/role-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Role role = roleDAO.getRoleById(id);
        request.setAttribute("role", role);
        request.getRequestDispatcher("/role-form.jsp").forward(request, response);
    }

    private void addRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("اسمالدور");
        String description = request.getParameter("وصفالدور");

        Role role = new Role();
        role.setاسمالدور(name);
        role.setوصفالدور(description);

        roleDAO.addRole(role);
        response.sendRedirect("roles");
    }

    private void updateRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("معرف_الدور"));
        String name = request.getParameter("اسمالدور");
        String description = request.getParameter("وصفالدور");

        Role role = new Role();
        role.setMعرف_الدور(id);
        role.setاسمالدور(name);
        role.setوصفالدور(description);

        roleDAO.updateRole(role);
        response.sendRedirect("roles");
    }

    private void deleteRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        roleDAO.deleteRole(id);
        response.sendRedirect("roles");
    }
}