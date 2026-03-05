<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="members.aspx.cs" Inherits="WebApplication6.members" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gym Membership</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            background: url('images/Backg1.jpeg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', sans-serif;
        }

        /* Dark overlay */
        .overlay {
            background: rgba(0, 0, 0, 0.75);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 0;
        }

        /* Main Glass Container */
        .container {
            width: 950px;
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(12px);
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 40px rgba(255, 140, 0, 0.4);
            color: white;
        }

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            margin-bottom: 30px;
            border-bottom: 2px solid orange;
        }

        .nav-left {
            display: flex;
            align-items: center;
        }

        .logo-img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-right: 12px;
            border: 2px solid orange;
        }

        .gym-name {
            font-size: 22px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .nav-right .btn-orange {
            margin-left: 10px;
        }

        /* Buttons */
        .btn-orange {
            background: linear-gradient(45deg, orange, darkorange);
            border: none;
            padding: 10px 22px;
            color: white;
            border-radius: 25px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s ease;
            box-shadow: 0 0 12px rgba(255, 165, 0, 0.6);
        }

            .btn-orange:hover {
                transform: scale(1.05);
                box-shadow: 0 0 20px orange;
            }

        /* Form Styling */
        .form-group {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

            .form-group label {
                width: 260px;
                font-size: 17px;
                font-weight: 500;
            }

        /* Inputs */
        input[type=text],
        select,
        textarea {
            width: 320px;
            padding: 10px;
            border-radius: 8px;
            border: none;
            font-size: 15px;
            outline: none;
        }

            /* Dropdown & textbox focus effect */
            input[type=text]:focus,
            select:focus {
                box-shadow: 0 0 10px orange;
            }

        /* Checkbox & CheckboxList */
        input[type=checkbox] {
            transform: scale(1.2);
        }

        /* BMI Label */
        #Label1 {
            font-weight: bold;
            font-size: 18px;
            color: orange;
        }

        /* Bottom Buttons */
        .bottom-buttons {
            text-align: center;
            margin-top: 30px;
        }

            .bottom-buttons .btn-orange {
                margin: 0 10px;
            }

        /* Responsive */
        @media (max-width: 1000px) {
            .container {
                width: 90%;
            }

            .form-group {
                flex-direction: column;
                align-items: flex-start;
            }

                .form-group label {
                    margin-bottom: 5px;
                }

            input[type=text],
            select {
                width: 100%;
            }
        }

        /* ================= GRIDVIEW STYLING ================= */

        asp\\:GridView {
            width: 100%;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        /* Header */

        th {
            background: linear-gradient(45deg, orange, darkorange);
            color: white;
        }

        .grid-style th {
            background: linear-gradient(45deg, orange, darkorange) !important;
            color: white !important;
            padding: 12px;
            text-align: center;
            font-weight: bold;
            font-size: 15px;
        }

        .grid-style {
            min-width: 1600px;
            background: rgba(0, 0, 0, 0.6); /* darker background */
            border-radius: 10px;
        }



        /* Rows */
        td {
            padding: 10px;
            text-align: center;
            color: white;
            font-size: 14px;
        }

        /* Alternating rows */
        tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.08);
        }

        /* Hover effect */
        tr:hover {
            background: rgba(255, 165, 0, 0.2);
            transition: 0.3s;
        }

        /* Select button */
        input[type=submit] {
            background: orange;
            border: none;
            padding: 6px 12px;
            border-radius: 20px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

            input[type=submit]:hover {
                background: darkorange;
                box-shadow: 0 0 10px orange;
            }

        /* Paging */
        table tr:last-child td {
            background: rgba(0, 0, 0, 0.3);
        }

        a {
            color: orange;
            font-weight: bold;
            text-decoration: none;
            margin: 0 5px;
        }

            a:hover {
                text-decoration: underline;
            }


        .grid-header {
            background: linear-gradient(45deg, orange, darkorange);
            color: white;
            font-weight: bold;
            text-align: center;
        }

        .grid-row {
            background: rgba(255,255,255,0.05);
            color: white;
        }

        .grid-alt-row {
            background: rgba(255,255,255,0.1);
        }

        /* Scrollable Grid */
        .grid-wrapper {
            width: 100%;
            overflow-x: auto;
            margin-top: 20px;
        }

        /* Prevent table from shrinking */
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="overlay">
            <div class="container">
                <asp:Label ID="Label1" runat="server" Text="Label">Members List</asp:Label>
                <div class="grid-wrapper">
                    <asp:GridView ID="GridView1" runat="server"
                        CssClass="grid-style"
                        AllowPaging="True"
                        AllowSorting="True"
                        DataSourceID="SqlDataSource1"
                        AutoGenerateColumns="False"
                        DataKeyNames="MemberID"
                        HeaderStyle-BackColor="Orange"
                        HeaderStyle-ForeColor="White"
                        HeaderStyle-Font-Bold="True">

                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="MemberID" HeaderText="MemberID" InsertVisible="False" ReadOnly="True" SortExpression="MemberID" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                            <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                            <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                            <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                            <asp:BoundField DataField="MembershipType" HeaderText="MembershipType" SortExpression="MembershipType" />
                            <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration" />
                            <asp:CheckBoxField DataField="TrainerRequired" HeaderText="TrainerRequired" SortExpression="TrainerRequired" />
                            <asp:BoundField DataField="TrainerName" HeaderText="TrainerName" SortExpression="TrainerName" />
                            <asp:BoundField DataField="MedicalConditions" HeaderText="MedicalConditions" SortExpression="MedicalConditions" />
                            <asp:BoundField DataField="Height" HeaderText="Height" SortExpression="Height" />
                            <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" />
                            <asp:BoundField DataField="BMI" HeaderText="BMI" SortExpression="BMI" />
                            <asp:BoundField DataField="PaymentMode" HeaderText="PaymentMode" SortExpression="PaymentMode" />
                            <asp:BoundField DataField="JoiningDate" HeaderText="JoiningDate" SortExpression="JoiningDate" />
                        </Columns>
                    </asp:GridView>
                </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GYM_REGISTERATION_FORMConnectionString %>" ProviderName="<%$ ConnectionStrings:GYM_REGISTERATION_FORMConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [Members]" UpdateCommand="UPDATE Members SET Name=@Name, Gender=@Gender, Age=@Age, Mobile=@Mobile, Email=@Email, MembershipType=@MembershipType, Duration=@Duration, TrainerRequired=@TrainerRequired, TrainerName=@TrainerName, MedicalConditions=@MedicalConditions, Height=@Height, Weight=@Weight, BMI=@BMI, PaymentMode=@PaymentMode, JoiningDate=@JoiningDate WHERE MemberID=@MemberID"
DeleteCommand="DELETE FROM Members WHERE MemberID=@MemberID"></asp:SqlDataSource>

            <div style="text-align: center; margin-top: 20px;">
                <div class="bottom-buttons">
                    &nbsp;&nbsp;
                        <asp:Button ID="Button1" runat="server" Text="Back" CssClass="btn-orange" OnClick="Button1_Click" />

                </div>
            </div>
        </div>
</div>
    </form>
</body>
</html>
