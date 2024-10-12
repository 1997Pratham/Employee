using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Employee
{
    public partial class _default : System.Web.UI.Page
    {
        public List<Employee> employees;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                employees = GetEmployees();
            }
        }

        private List<Employee> GetEmployees()
        {
            var employeesList = new List<Employee>();
            string connectionString = "Data Source=PACKING1\\MSSQLSERVER01;Initial Catalog=EmployeeManagementSystem;Integrated Security=True";
            string query = "SELECT * FROM Employee";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            employeesList.Add(new Employee
                            {
                                EmpID = reader.GetInt32(0),
                                Name = reader.GetString(1),
                                City = reader.GetString(2),
                                Email = reader.GetString(3),
                                DOB = reader.GetDateTime(4),
                                ContactNo = reader.GetString(5)
                            });
                        }
                    }
                }
            }

            return employeesList;
        }

        public class Employee
        {
            public int EmpID { get; set; }
            public string Name { get; set; }
            public string City { get; set; }
            public string Email { get; set; }
            public DateTime DOB { get; set; }
            public string ContactNo { get; set; }
        }

        [System.Web.Services.WebMethod]
        public static string AddEmployee(string name, string city, string email, string dob, string contactNo)
        {
            string connectionString = "Data Source=PACKING1\\MSSQLSERVER01;Initial Catalog=EmployeeManagementSystem;Integrated Security=True";
            string query = "INSERT INTO Employee (Name, City, Email, DOB, ContactNo) VALUES (@Name, @City, @Email, @DOB, @ContactNo)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@City", city);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@DOB", dob);
                    command.Parameters.AddWithValue("@ContactNo", contactNo);

                    command.ExecuteNonQuery();
                }
            }

            return "success";
        }
        [System.Web.Services.WebMethod]
        public static Employee EditEmployee(int empID)
        {
            string connectionString = "Data Source=PACKING1\\MSSQLSERVER01;Initial Catalog=EmployeeManagementSystem;Integrated Security=True";
            string query = "SELECT * FROM Employee WHERE EmpID = @EmpID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@EmpID", empID);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Employee
                            {
                                EmpID = reader.GetInt32(0),
                                Name = reader.GetString(1),
                                City = reader.GetString(2),
                                Email = reader.GetString(3),
                                DOB = reader.GetDateTime(4),
                                ContactNo = reader.GetString(5)
                            };
                        }
                    }
                }
            }

            return null;
        }


        [System.Web.Services.WebMethod]
        public static string UpdateEmployee(int empID, string name, string city, string email, string dob, string contactNo)
        {
            string connectionString = "Data Source=PACKING1\\MSSQLSERVER01;Initial Catalog=EmployeeManagementSystem;Integrated Security=True";
            string query = "UPDATE Employee SET Name = @Name, City = @City, Email = @Email, DOB = @DOB, ContactNo = @ContactNo WHERE EmpID = @EmpID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@EmpID", empID);
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@City", city);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@DOB", dob);
                    command.Parameters.AddWithValue("@ContactNo", contactNo);

                    command.ExecuteNonQuery();
                }
            }

            return "success";
        }

        [System.Web.Services.WebMethod]
        public static string DeleteEmployee(int empID)
        {
            string connectionString = "Data Source=PACKING1\\MSSQLSERVER01;Initial Catalog=EmployeeManagementSystem;Integrated Security=True";
            string query = "DELETE FROM Employee WHERE EmpID = @EmpID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@EmpID", empID);

                    command.ExecuteNonQuery();
                }
            }

            return "success";
        }

    }

}

