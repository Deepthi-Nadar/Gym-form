<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="start.aspx.cs" Inherits="WebApplication7.start" %>

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
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 0;
        }

        /* Main Glass Container */
        .container {
            width: 500px;
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(12px);
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 40px rgba(255, 140, 0, 0.4);
            color: white;
        }

        .center-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            margin-top: 20px;
        }

        .logo-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 3px solid orange;
            margin-bottom: 15px;
            padding: 10px;
            background: rgba(255,255,255,0.05);
            box-shadow: 0 0 20px orange;
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            animation: pulseGlow 2s infinite alternate;
        }

        @keyframes pulseGlow {
            from {
                box-shadow: 0 0 15px orange;
            }

            to {
                box-shadow: 0 0 45px orange;
            }
        }



        .gym-name {
            font-size: 28px;
            font-weight: bold;
            letter-spacing: 2px;
        }

        .nav-right .btn-orange {
            margin-left: 10px;
        }

        /* Buttons */

        .bottom-buttons {
            text-align: center;
            margin-top: 30px;
        }

        .btn-orange {
            background: linear-gradient(45deg, orange, darkorange);
            border: none;
            padding: 10px 22px;
            color: white;
            border-radius: 25px;
            font-weight: bold;
            font-size: 26px;
            cursor: pointer;
            box-shadow: 0 0 12px rgba(255, 165, 0, 0.6);
        }

            .btn-orange:hover {
                transform: scale(1.05);
                box-shadow: 0 0 20px orange;
            }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="overlay">
            <div class="container">
                <div class="center-content">
                    <img src="images/image-removebg-preview (1).png" class="logo-img" />
                    <div class="gym-name">POWER GYM</div>

                </div>

            </div>
            <div class="bottom-buttons">
                <asp:Button ID="Start" runat="server" Text="START" CssClass="btn-orange"  onClick="Start_Click"/>

            </div>

        </div>
    </form>
</body>
</html>
