
---

# Employee Management System

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Project Structure](#project-structure)
5. [Setup and Installation](#setup-and-installation)
6. [Usage](#usage)
7. [Contributing](#contributing)
8. [License](#license)
9. [Contact](#contact)

---

## Overview

The **Employee Management System** is a Java EE (JEE) web application designed to manage employees, roles, and their assignments within an organization. It provides a user-friendly interface for adding, editing, deleting, and viewing employees and roles, as well as assigning roles to employees.

This system is built using JSP, Servlets, JDBC, MySQL, Bootstrap, and Tomcat, ensuring a robust and scalable solution for managing employee data.

---

## Features

- **Employee Management**: Add, edit, delete, and view employee details such as name and email.
- **Role Management**: Define and manage roles with descriptions.
- **Role Assignment**: Assign roles to employees and track their assignments.
- **Responsive UI**: Built with Bootstrap for a modern and responsive design.
- **CRUD Operations**: Full support for Create, Read, Update, and Delete operations.
- **Pagination**: Navigate through large datasets with ease.
- **User-Friendly Interface**: Intuitive dashboard for easy navigation.

---

## Technologies Used

- **Backend**: Java EE (JSP & Servlets), JDBC
- **Database**: MySQL
- **Frontend**: HTML, CSS, Bootstrap
- **Web Server**: Apache Tomcat
- **Development Tools**: Eclipse/IntelliJ IDEA

---

## Project Structure

The project follows a clean and organized structure:

```
project-name/
├── src/
│   ├── model/                # JavaBeans for entities (Role, Employee, EmployeeRole)
│   │   ├── Role.java
│   │   ├── Employee.java
│   │   └── EmployeeRole.java
│   ├── dao/                  # Data Access Objects (DAOs)
│   │   ├── RoleDAO.java
│   │   ├── EmployeeDAO.java
│   │   └── EmployeeRoleDAO.java
│   └── servlet/              # Servlets for handling HTTP requests
│       ├── RoleServlet.java
│       ├── EmployeeServlet.java
│       └── EmployeeRoleServlet.java
├── WEB-INF/
│   ├── lib/                  # External libraries (e.g., MySQL JDBC driver)
│   ├── views/                # JSP pages for the UI
│   │   ├── index.jsp         # Dashboard
│   │   ├── roles.jsp         # List of roles
│   │   ├── add_role.jsp      # Form to add a role
│   │   ├── edit_role.jsp     # Form to edit a role
│   │   ├── employees.jsp     # List of employees
│   │   ├── add_employee.jsp  # Form to add an employee
│   │   ├── edit_employee.jsp # Form to edit an employee
│   │   ├── employee_roles.jsp # List of employee-role assignments
│   │   ├── add_employee_role.jsp # Form to assign a role to an employee
│   │   └── edit_employee_role.jsp # Form to edit an assignment
│   └── web.xml               # Deployment descriptor
├── build/                    # Compilation output directory
└── README.md                 # Documentation
```

---

## Setup and Installation

### Prerequisites
- Java Development Kit (JDK) 8 or higher
- Apache Tomcat 8 or higher
- MySQL Database
- IDE (e.g., Eclipse, IntelliJ IDEA)

### Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/kinanix7/Enterprise-Management-System.git
   ```

2. **Set Up the Database**
   - Create a database named `entreprise` in MySQL.
   - Execute the SQL script to create tables (`الأدوار`, `الموظفون`, `الموظفون_الأدوار`).

   Example SQL Script:
   ```sql
   CREATE DATABASE entreprise;
   USE entreprise;

   CREATE TABLE الأدوار (
       معرف_الدور INT AUTO_INCREMENT PRIMARY KEY,
       اسم_الدور VARCHAR(50) NOT NULL,
       وصف_الدور TEXT
   );

   CREATE TABLE الموظفون (
       معرف_الموظف INT AUTO_INCREMENT PRIMARY KEY,
       الاسم VARCHAR(100) NOT NULL,
       البريد_الإلكتروني VARCHAR(100) UNIQUE NOT NULL
   );

   CREATE TABLE الموظفون_الأدوار (
       معرف_الموظف INT,
       معرف_الدور INT,
       تاريخ_التعيين DATE,
       PRIMARY KEY (معرف_الموظف, معرف_الدور),
       FOREIGN KEY (معرف_الموظف) REFERENCES الموظفون(معرف_الموظف) ON DELETE CASCADE,
       FOREIGN KEY (معرف_الدور) REFERENCES الأدوار(معرف_الدور) ON DELETE CASCADE
   );
   ```

3. **Configure Database Connection**
   - Update the database connection details in the servlets (e.g., `RoleServlet`, `EmployeeServlet`).

   Example:
   ```java
   Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/entreprise", "root", "");
   ```

4. **Deploy the Application**
   - Build the project using your IDE.
   - Deploy the WAR file to Apache Tomcat.

5. **Run the Application**
   - Start the Tomcat server.
   - Access the application at `http://localhost:8080/<project-name>`.

---

## Usage

1. **Dashboard**: The home page provides quick access to manage employees, roles, and role assignments.
2. **Manage Roles**: Add, edit, or delete roles from the "Roles" section.
3. **Manage Employees**: Add, edit, or delete employees from the "Employees" section.
4. **Assign Roles**: Assign roles to employees and view their assignments in the "Employee Roles" section.

---

## Contributing

 Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact

For any questions or support, please contact:

- Email: kinani.busines@gmail.com

  

---

