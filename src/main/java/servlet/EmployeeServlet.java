package servlet;

import dao.EmployeeDAO;
import model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {
    private EmployeeDAO employeeDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        employeeDAO = new EmployeeDAO();
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
                deleteEmployee(request, response);
                break;
            default:
                listEmployees(request, response);
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
                addEmployee(request, response);
                break;
            case "update":
                updateEmployee(request, response);
                break;
            default:
                listEmployees(request, response);
                break;
        }
    }

    private void listEmployees(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Employee> employees = employeeDAO.getAllEmployees();
        request.setAttribute("employees", employees);
        request.getRequestDispatcher("/employees.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/employee-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Employee employee = employeeDAO.getEmployeeById(id);
        request.setAttribute("employee", employee);
        request.getRequestDispatcher("/employee-form.jsp").forward(request, response);
    }

    private void addEmployee(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("الاسم");
        String email = request.getParameter("البريدالإلكتروني");

        Employee employee = new Employee();
        employee.setالاسم(name);
        employee.setالبريدالإلكتروني(email);

        employeeDAO.addEmployee(employee);
        response.sendRedirect("employees");
    }

    private void updateEmployee(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("معرفالموظف"));
        String name = request.getParameter("الاسم");
        String email = request.getParameter("البريدالإلكتروني");

        Employee employee = new Employee();
        employee.setMعرفالموظف(id);
        employee.setالاسم(name);
        employee.setالبريدالإلكتروني(email);

        employeeDAO.updateEmployee(employee);
        response.sendRedirect("employees");
    }

    private void deleteEmployee(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        employeeDAO.deleteEmployee(id);
        response.sendRedirect("employees");
    }
}