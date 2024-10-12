<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Employee._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Management System</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
   <form id="form1" runat="server">
        <div class="container">
            <h2>Employee Management System</h2>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addEmployeeModal">Add Employee</button>           
            <table id="employeeTable" class="table table-striped table-bordered">  
                <thead>
                    <tr>
                        <th>EmpID</th>
                        <th>Name</th>
                        <th>City</th>
                        <th>Email</th>
                        <th>DOB</th>
                        <th>ContactNo</th>             
                    </tr>
                </thead>
                <tbody>
                    <% foreach (var employee in employees)
                        { %>
                    <tr>
                        <td><%= employee.EmpID %></td>
                        <td><%= employee.Name %></td>
                        <td><%= employee.City %></td>
                        <td><%= employee.Email %></td>
                        <td><%= employee.DOB.ToString("yyyy-MM-dd") %></td>
                        <td><%= employee.ContactNo %></td>                    
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editEmployeeModal" onclick="editEmployee(<%= employee.EmpID %>);">Edit</button>
                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteEmployeeModal" onclick="setDeleteEmployeeId(<%= employee.EmpID %>);">Delete</button>
                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#SelectEmployeeModal" onclick="setSelectEmployeeId(<%= employee.EmpID %>);">Select</button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>

            </table>
        </div>

        <!-- Add Employee Modal -->
        <div id="addEmployeeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add Employee</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="txtName">Name:</label>
                            <input type="text" class="form-control" id="txtName" />
                        </div>
                        <div class="form-group">
                            <label for="txtCity">City:</label>
                            <input type="text" class="form-control" id="txtCity" />
                        </div>
                        <div class="form-group">
                            <label for="txtEmail">Email:</label>
                            <input type="email" class="form-control" id="txtEmail" />
                        </div>
                        <div class="form-group">
                            <label for="txtDOB">DOB:</label>
                            <input type="date" class="form-control" id="txtDOB" />
                        </div>
                        <div class="form-group">
                            <label for="txtContactNo">ContactNo:</label>
                            <input type="text" class="form-control" id="txtContactNo" />
                           
                            <%--<input type="text" class="form-control" id="txtContactNo" pattern="\d{10}" maxlength="10" onkeypress="return isNumberKey(event)" />--%>
                        </div>                    
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="btnAddEmployee">Add Employee</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Employee Modal -->
        <div id="editEmployeeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Edit Employee</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="hdnEditEmpID" />
                        <div class="form-group">
                            <label for="txtEditName">Name:</label>
                            <input type="text" class="form-control" id="txtEditName" />
                        </div>
                        <div class="form-group">
                            <label for="txtEditCity">City:</label>
                            <input type="text" class="form-control" id="txtEditCity" />
                        </div>
                        <div class="form-group">
                            <label for="txtEditEmail">Email:</label>
                            <input type="email" class="form-control" id="txtEditEmail" />
                        </div>
                        <div class="form-group">
                            <label for="txtEditDOB">DOB:</label>
                            <input type="date" class="form-control" id="txtEditDOB" />
                        </div>
                        <div class="form-group">
                            <label for="txtEditContactNo">ContactNo:</label>
                            <input type="text" class="form-control" id="txtEditContactNo" />

                        </div>                    
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="btnUpdateEmployee">Update Employee</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Employee Modal -->
        <div id="deleteEmployeeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Delete Employee</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this employee?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="btnConfirmDelete">Delete</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Select Employee Modal -->
        <div id="SelectEmployeeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Select Employee</h4>
                    </div>
                    <div class="modal-body">
                        <div class="modal-body">
                            <input type="hidden" id="hdnSelectEmpID" />
                            <div class="form-group">
                                <label for="txtstrdate">Start Date:</label>
                                <input type="text" class="form-control" id="txtstrdate" />
                            </div>
                            <div class="form-group">
                                <label for="txtEnddate">End Date:</label>
                                <input type="text" class="form-control" id="txtEnddate" />
                            </div>
                            <div class="form-group">
                                <label for="txtYoE">Year Of Experiance:</label>
                                <input type="email" class="form-control" id="txtYoE" />
                            </div>
                            <div class="form-group">
                                <label for="txtCom">Company:</label>
                                <input type="date" class="form-control" id="txtCom" />
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="btnSelectEmp">Select</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>


        <script>
            $(document).ready(function () {
                $("#btnAddEmployee").click(function () {
                    // Validate fields before proceeding
                    if (!validateAddEmployeeFields()) return;

                    var name = $("#txtName").val();
                    var city = $("#txtCity").val();
                    var email = $("#txtEmail").val();
                    var dob = $("#txtDOB").val();
                    var contactNo = $("#txtContactNo").val();

                    $.ajax({
                        type: "POST",
                        url: "default.aspx/AddEmployee",
                        data: JSON.stringify({ name: name, city: city, email: email, dob: dob, contactNo: contactNo }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "success") {
                                alert("Employee added successfully!");
                                location.reload();
                            } else {
                                alert("Error adding employee!");
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("Error: " + error);
                        }
                    });
                });

                // Validate fields for adding employee
                function validateAddEmployeeFields() {
                    let isValid = true;
                    let validationMessages = []; 

                    if ($("#txtName").val().trim() === "") {
                        validationMessages.push("Name is required.");
                        isValid = false;
                    }
                    if ($("#txtCity").val().trim() === "") {
                        validationMessages.push("City is required.");
                        isValid = false;
                    }
                    if ($("#txtEmail").val().trim() === "") {
                        validationMessages.push("Email is required.");
                        isValid = false;
                    } else if (!validateEmail($("#txtEmail").val())) {
                        validationMessages.push("Please enter a valid email address.");
                        isValid = false;
                    }
                    if ($("#txtDOB").val() === "") {
                        validationMessages.push("Date of Birth is required.");
                        isValid = false;
                    }
                    if ($("#txtContactNo").val().trim() === "") {
                        validationMessages.push("Contact No is required.");
                        isValid = false;
                    } else if (!/^\d{10}$/.test($("#txtContactNo").val())) {
                        validationMessages.push("Contact No must be exactly 10 digits.");
                        isValid = false;
                    }

                    // If there are validation messages, show them in one alert
                    if (!isValid) {
                        alert(validationMessages.join("\n")); // Join messages with new line
                    }

                    return isValid;
                }

                // Validate email format
                function validateEmail(email) {
                    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    return re.test(email);
                }

                // Update Employee
                $("#btnUpdateEmployee").click(function () {
                    if (!validateEditEmployeeFields()) return;

                    var empID = $("#hdnEditEmpID").val();
                    var name = $("#txtEditName").val();
                    var city = $("#txtEditCity").val();
                    var email = $("#txtEditEmail").val();
                    var dob = $("#txtEditDOB").val();
                    var contactNo = $("#txtEditContactNo").val();

                    $.ajax({
                        type: "POST",
                        url: "default.aspx/UpdateEmployee",
                        data: JSON.stringify({ empID: empID, name: name, city: city, email: email, dob: dob, contactNo: contactNo }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "success") {
                                alert("Employee updated successfully!");
                                location.reload();
                            } else {
                                alert("Error updating employee!");
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("Error: " + error);
                        }
                    });
                });

                // Validate fields for editing employee
                function validateEditEmployeeFields() {
                    let isValid = true;

                    if ($("#txtEditName").val().trim() === "") {
                        alert("Name is required.");
                        isValid = false;
                    }
                    if ($("#txtEditCity").val().trim() === "") {
                        alert("City is required.");
                        isValid = false;
                    }
                    if ($("#txtEditEmail").val().trim() === "") {
                        alert("Email is required.");
                        isValid = false;
                    } else if (!validateEmail($("#txtEditEmail").val())) {
                        alert("Please enter a valid email address.");
                        isValid = false;
                    }
                    if ($("#txtEditDOB").val() === "") {
                        alert("Date of Birth is required.");
                        isValid = false;
                    }
                    if ($("#txtEditContactNo").val().trim() === "") {
                        alert("Contact No is required.");
                        isValid = false;
                    } else if (!$.isNumeric($("#txtEditContactNo").val())) {
                        alert("Contact No must be a number.");
                        isValid = false;
                    }

                    return isValid;
                }
            });
                // Edit Employee
                window.editEmployee = function (empID) {
                    $.ajax({
                        type: "POST",
                        url: "default.aspx/EditEmployee",
                        data: JSON.stringify({ empID: empID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d) {
                                $("#hdnEditEmpID").val(data.d.EmpID);
                                $("#txtEditName").val(data.d.Name);
                                $("#txtEditCity").val(data.d.City);
                                $("#txtEditEmail").val(data.d.Email);
                                $("#txtEditDOB").val(data.d.DOB.split('T')[0]); // Format for input
                                $("#txtEditContactNo").val(data.d.ContactNo);
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("Error fetching employee details: " + error);
                        }
                    });
                };
            // Delete Employee
            window.setDeleteEmployeeId = function (empID) {
                console.log("Setting employee ID for deletion:", empID); // Debug log

                $("#btnConfirmDelete").off('click').on('click', function () {
                    console.log("Confirm delete button clicked."); // Debug log
                    $.ajax({
                        type: "POST",
                        url: "default.aspx/DeleteEmployee",
                        data: JSON.stringify({ empID: empID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            console.log("Delete response:", data); // Debug log
                            if (data.d === "success") {
                                alert("Employee deleted successfully!");
                                location.reload();
                            } else {
                                alert("Error deleting employee!");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Error deleting employee:", error); // Log the error for debugging
                            alert("Error: " + error);
                        }
                    });
                });
            };
        </script>
    </form>
</body>
</html>