using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication7
{
    public partial class GymForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label1.Text = "";
            }
        }

        // MEMBERS BUTTON
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("members.aspx");
        }

        // BMI CALCULATION (Auto)
        protected void CalculateBMI(object sender, EventArgs e)
        {
            double height, weight;

            bool isHeightValid = double.TryParse(txtHeight.Text.Trim(), out height);
            bool isWeightValid = double.TryParse(txtWeight.Text.Trim(), out weight);

            if (isHeightValid && isWeightValid && height > 0)
            {
                double bmi = weight / ((height / 100) * (height / 100));
                Label1.Text = bmi.ToString("0.00");
            }
            else
            {
                Label1.Text = "";
            }
        }

        // BACK BUTTON
        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("start.aspx");
        }


        protected void ValidateMedicalConditions(object source, ServerValidateEventArgs args)
        {
            bool isSelected = false;

            foreach (ListItem item in CheckBoxList1.Items)
            {
                if (item.Selected)
                {
                    isSelected = true;
                    break;
                }
            }

            args.IsValid = isSelected;
        }


        // CALENDAR DATE
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            lblSelectedDate.Text = "You selected: " + Calendar1.SelectedDate.ToShortDateString();
        }

        // SUBMIT BUTTON
        protected void Button3_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            // DATE VALIDATION
            int currentYear = DateTime.Now.Year;

            if (Calendar1.SelectedDate == DateTime.MinValue)
            {
                lblMessage.Text = "Please select a joining date";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (Calendar1.SelectedDate.Year < currentYear || Calendar1.SelectedDate.Year > currentYear + 10)
            {
                lblMessage.Text = "Date must be between " + currentYear + " and " + (currentYear + 10);
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // PAYMENT VALIDATION
            if (rblPaymentMode.SelectedIndex == -1)
            {
                lblMessage.Text = "Please select payment mode";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // HEIGHT & WEIGHT VALIDATION
            double height, weight;

            if (!double.TryParse(txtHeight.Text, out height) || height <= 0)
            {
                lblMessage.Text = "Enter valid height";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (!double.TryParse(txtWeight.Text, out weight) || weight <= 0)
            {
                lblMessage.Text = "Enter valid weight";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // CALCULATE BMI
            double bmi = weight / ((height / 100) * (height / 100));

            // TRAINER VALIDATION
            if (CheckBox1.Checked && DropDownList3.SelectedValue == "Not Selected")
            {
                lblMessage.Text = "Please select a trainer";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // MEDICAL CONDITIONS
            string medical = "";
            foreach (ListItem item in CheckBoxList1.Items)
            {
                if (item.Selected)
                    medical += item.Text + ", ";
            }

            if (medical.EndsWith(", "))
                medical = medical.Substring(0, medical.Length - 2);

            // FILE UPLOAD
            string fileName = "";
            lblFileError.Text = "";

            if (!FileUpload1.HasFile)
            {
                lblFileError.Text = "Please upload a file.";
                lblFileError.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string extension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
            string contentType = FileUpload1.PostedFile.ContentType;
            int fileSize = FileUpload1.PostedFile.ContentLength;

            bool isValidType =
                ((extension == ".jpg" || extension == ".jpeg") && contentType == "image/jpeg") ||
                (extension == ".png" && contentType == "image/png") ||
                (extension == ".pdf" && contentType == "application/pdf");

            if (!isValidType)
            {
                lblFileError.Text = "Only JPG, JPEG, PNG, PDF allowed.";
                return;
            }

            if (fileSize > 2 * 1024 * 1024)
            {
                lblFileError.Text = "File must be less than 2MB.";
                return;
            }

            try
            {
                string folderPath = Server.MapPath("~/IDProofs/");
                if (!System.IO.Directory.Exists(folderPath))
                {
                    System.IO.Directory.CreateDirectory(folderPath);
                }

                fileName = Guid.NewGuid().ToString() + extension;
                FileUpload1.SaveAs(folderPath + fileName);
            }
            catch (Exception ex)
            {
                lblFileError.Text = "Upload failed: " + ex.Message;
                return;
            }

            string trainerRequired = CheckBox1.Checked ? "Yes" : "No";

            // DATABASE INSERT
            try
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["GYM_REGISTERATION_FORMConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(
                        "INSERT INTO Members (Name, Gender, Age, Mobile, Email, Address, MembershipType, Duration, TrainerRequired, TrainerName, MedicalConditions, Height, Weight, BMI, PaymentMode, JoiningDate) " +
                        "VALUES (@Name,@Gender,@Age,@Mobile,@Email,@Address,@MembershipType,@Duration,@TrainerRequired,@TrainerName,@MedicalConditions,@Height,@Weight,@BMI,@PaymentMode,@JoiningDate)", con))
                    {
                        cmd.Parameters.AddWithValue("@Name", txtName.Text);
                        cmd.Parameters.AddWithValue("@Gender", rblGender.SelectedValue);
                        cmd.Parameters.AddWithValue("@Age", txtAge.Text);
                        cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                        cmd.Parameters.AddWithValue("@MembershipType", DropDownList1.SelectedValue);
                        cmd.Parameters.AddWithValue("@Duration", DropDownList2.SelectedValue);
                        cmd.Parameters.AddWithValue("@TrainerRequired", trainerRequired);
                        cmd.Parameters.AddWithValue("@TrainerName", DropDownList3.SelectedValue);
                        cmd.Parameters.AddWithValue("@MedicalConditions", medical);
                        cmd.Parameters.AddWithValue("@Height", height);
                        cmd.Parameters.AddWithValue("@Weight", weight);
                        cmd.Parameters.AddWithValue("@BMI", bmi);
                        cmd.Parameters.AddWithValue("@PaymentMode", rblPaymentMode.SelectedValue);
                        cmd.Parameters.AddWithValue("@JoiningDate", Calendar1.SelectedDate);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Member Registered Successfully!";
                lblMessage.ForeColor = System.Drawing.Color.LightGreen;

                ClearForm();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        // CLEAR FORM
        private void ClearForm()
        {
            txtName.Text = "";
            txtAge.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";
            txtAddress.Text = "";
            txtHeight.Text = "";
            txtWeight.Text = "";
            Label1.Text = "";

            rblGender.ClearSelection();
            rblPaymentMode.ClearSelection();
            DropDownList1.SelectedIndex = 0;
            DropDownList2.SelectedIndex = 0;
            DropDownList3.SelectedIndex = 0;
            CheckBox1.Checked = false;

            foreach (ListItem item in CheckBoxList1.Items)
            {
                item.Selected = false;
            }

            lblSelectedDate.Text = "";
        }
    }
}