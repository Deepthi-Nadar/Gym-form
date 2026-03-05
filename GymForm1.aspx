<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GymForm1.aspx.cs" Inherits="WebApplication6.GymForm1" %>

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

            /* textbox focus effect */
            input[type=text]:focus,
            select:focus {
                box-shadow: 0 0 10px orange;
            }

        /* Checkbox */
        input[type=checkbox] {
            transform: scale(1.2);
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
    </style>

</head>
<body>
    <form id="form1" runat="server">
<div class="overlay">
<div class="container">

    <!-- NAVBAR -->
    <div class="navbar">
        <div class="nav-left">
            <img src="images/image-removebg-preview (1).png" class="logo-img" alt="Gym Logo" />
            <span class="gym-name">POWER GYM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
        &nbsp;<asp:Button ID="Button1" runat="server" Text="Members" CssClass="btn-orange" OnClick="Button1_Click" CausesValidation="False"/>
        </div>

        <div class="nav-right">
        </div>
    </div>

    <!-- MEMBER NAME -->
    <div class="form-group">
        <label>Member Name:</label>
        <asp:TextBox ID="txtName" runat="server" />
    </div>

    <!-- GENDER -->
    <div class="form-group">
        <label>Gender:</label>
        <asp:RadioButtonList ID="rblGender" runat="server">
            <asp:ListItem Text="♂ Male" Value="Male" />
            <asp:ListItem Text="♀ Female" Value="Female" />
        </asp:RadioButtonList>
    </div>

    <!-- AGE -->
    <div class="form-group">
        <label>Age:</label>
        <asp:TextBox ID="txtAge" runat="server" />
        <asp:RangeValidator ID="rvAge" runat="server"
            ControlToValidate="txtAge"
            MinimumValue="18"
            MaximumValue="60"
            Type="Integer"
            ErrorMessage="Age must be between 18 and 60"
            ForeColor="Red" />
    </div>

    <!-- MOBILE -->
    <div class="form-group">
        <label>Mobile:</label>
        <asp:TextBox ID="txtMobile" runat="server" />
    </div>

    <!-- EMAIL -->
    <div class="form-group">
        <label>Email:</label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" />
    </div>

    <!-- ADDRESS -->
    <div class="form-group">
        <label>Address:</label>
        <asp:TextBox ID="txtAddress" runat="server"
            TextMode="MultiLine"
            Rows="4" />
    </div>

    <!-- MEMBERSHIP TYPE -->
    <div class="form-group">
        <label>Membership Type:</label>
        <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>Select Membership</asp:ListItem>
            <asp:ListItem>Basic</asp:ListItem>
            <asp:ListItem>Premium</asp:ListItem>
            <asp:ListItem>VIP</asp:ListItem>
        </asp:DropDownList>
    </div>

    <!-- DURATION -->
    <div class="form-group">
        <label>Duration (Months):</label>
        <asp:DropDownList ID="DropDownList2" runat="server">
            <asp:ListItem>-- Select Duration --</asp:ListItem>
            <asp:ListItem Value="1">1 Month</asp:ListItem>
            <asp:ListItem Value="3">3 Months</asp:ListItem>
            <asp:ListItem Value="6">6 Months</asp:ListItem>
            <asp:ListItem Value="12">12 Months</asp:ListItem>
        </asp:DropDownList>
    </div>

    <!-- TRAINER REQUIRED -->
    <div class="form-group">
        <label>Trainer Required:</label>
        <asp:CheckBox ID="CheckBox1" runat="server" />
    </div>

    <!-- PERSONAL TRAINER -->
    <div class="form-group">
        <label>Personal Trainer Name:</label>
        <asp:DropDownList ID="DropDownList3" runat="server">
            <asp:ListItem>-- Select Trainer --</asp:ListItem>
            <asp:ListItem>John</asp:ListItem>
            <asp:ListItem>Sarah</asp:ListItem>
            <asp:ListItem>Shaym</asp:ListItem>
            <asp:ListItem>Riko</asp:ListItem>
        </asp:DropDownList>
    </div>

    <!-- MEDICAL CONDITIONS -->
    <div class="form-group">
        <label>Medical Conditions:</label>
        <asp:CheckBoxList ID="CheckBoxList1" runat="server">
            <asp:ListItem Text="Diabetes" />
            <asp:ListItem Text="High Blood Pressure" />
            <asp:ListItem Text="Heart Problems" />
            <asp:ListItem Text="Asthma" />
            <asp:ListItem Text="None" />
        </asp:CheckBoxList>
    </div>

    <!-- HEIGHT -->
    <div class="form-group">
        <label>Height (cm):</label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    </div>

    <!-- WEIGHT -->
    <div class="form-group">
        <label>Weight (kg):</label>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </div>

    <!-- BMI -->
    <div class="form-group">
        <label>BMI:</label>
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </div>

    <!-- PAYMENT MODE -->
    <div class="form-group">
        <label>Payment Mode:</label>
        <asp:RadioButtonList ID="rblPaymentMode" runat="server">
            <asp:ListItem Value="Cash">Cash</asp:ListItem>
            <asp:ListItem Value="Card">Card</asp:ListItem>
            <asp:ListItem Value="UPI">UPI</asp:ListItem>
        </asp:RadioButtonList>

        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator1"
            runat="server"
            ControlToValidate="rblPaymentMode"
            ErrorMessage="* Required"
            ForeColor="Red">
        </asp:RequiredFieldValidator>
    </div>

    <!-- JOINING DATE -->
    <div class="form-group">
        <label>Joining Date:</label>
        <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
    </div>

    <!-- FILE UPLOAD -->
    <div class="form-group">
        <label>Upload ID Proof:</label>
        <asp:FileUpload ID="FileUpload1" runat="server" />
    </div>

    <!-- BUTTONS -->
    <div class="bottom-buttons">
        <asp:Button ID="Button2" runat="server" Text="Back" CssClass="btn-orange" OnClick="Button2_Click" CausesValidation="False" />
        <asp:Button ID="Button3" runat="server" Text="Submit" CssClass="btn-orange" OnClick="Button3_Click" />
    </div>

</div>
</div>

</form>
</body>
</html>
