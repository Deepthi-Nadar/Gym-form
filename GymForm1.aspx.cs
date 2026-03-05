using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class GymForm1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["GYM_REGISTERATION_FORMConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // MEMBERS BUTTON
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("members.aspx");
        }

        // BACK BUTTON
        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("start.aspx");
        }

        // SUBMIT BUTTON
        protected void Button3_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                // ✅ Calculate BMI
                double height = Convert.ToDouble(TextBox1.Text);
                double weight = Convert.ToDouble(TextBox2.Text);
                double bmi = weight / ((height / 100) * (height / 100));
                Label1.Text = bmi.ToString("0.00");

                // ✅ Medical Conditions
                string medical = "";
                foreach (ListItem item in CheckBoxList1.Items)
                {
                    if (item.Selected)
                        medical += item.Text + ", ";
                }

                // ✅ File Upload
                string fileName = "";

                if (FileUpload1.HasFile)
                {
                    string extension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();

                    if (extension == ".jpg" || extension == ".jpeg" ||
                        extension == ".png" || extension == ".pdf")
                    {
                        string folderPath = Server.MapPath("~/IDProofs/");
                        if (!System.IO.Directory.Exists(folderPath))
                            System.IO.Directory.CreateDirectory(folderPath);

                        fileName = Guid.NewGuid().ToString() + extension;
                        FileUpload1.SaveAs(folderPath + fileName);
                    }
                    else
                    {
                        Response.Write("<script>alert('Only jpg, jpeg, png, pdf allowed');</script>");
                        return;
                    }
                }

                // ✅ Insert into Database
                SqlCommand cmd = new SqlCommand(
                "INSERT INTO Members " +
                "(Name, Gender, Age, Mobile, Email, Address, MembershipType, Duration, TrainerRequired, TrainerName, MedicalConditions, Height, Weight, BMI, PaymentMode, JoiningDate) " +
                "VALUES (@Name,@Gender,@Age,@Mobile,@Email,@Address,@MembershipType,@Duration,@TrainerRequired,@TrainerName,@MedicalConditions,@Height,@Weight,@BMI,@PaymentMode,@JoiningDate)", con);

                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Gender", rblGender.SelectedValue);
                cmd.Parameters.AddWithValue("@Age", txtAge.Text);
                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                cmd.Parameters.AddWithValue("@MembershipType", DropDownList1.SelectedValue);
                cmd.Parameters.AddWithValue("@Duration", DropDownList2.SelectedValue);
                cmd.Parameters.AddWithValue("@TrainerRequired", CheckBox1.Checked);
                cmd.Parameters.AddWithValue("@TrainerName", DropDownList3.SelectedValue);
                cmd.Parameters.AddWithValue("@MedicalConditions", medical);
                cmd.Parameters.AddWithValue("@Height", height);
                cmd.Parameters.AddWithValue("@Weight", weight);
                cmd.Parameters.AddWithValue("@BMI", bmi);
                cmd.Parameters.AddWithValue("@PaymentMode", rblPaymentMode.SelectedValue);
                cmd.Parameters.AddWithValue("@JoiningDate", Calendar1.SelectedDate);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Write("<script>alert('Member Registered Successfully');</script>");

                ClearForm();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        // CLEAR FORM METHOD
        private void ClearForm()
        {
            txtName.Text = "";
            txtAge.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";
            txtAddress.Text = "";
            TextBox1.Text = "";
            TextBox2.Text = "";
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
        }
    }
}