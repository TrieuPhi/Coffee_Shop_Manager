using Coffee_Shop_Manager_2024.DAO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Coffee_Shop_Manager_2024
{
    public partial class fAdmin : Form
    {
        public fAdmin()
        {
            InitializeComponent();
            LoadAccountList(); 
        }
        void LoadAccountList()
        {

            void LoadFoodList()
            {
                string query = "select * from food";

                dtgvFood.DataSource = DataProvider.Instance.ExecuteQuery(query);
            }

            void LoadAccountList()
            {
                string query = "EXEC dbo.USP_GetAccountByUserName @userName";

                dtgvAccount.DataSource = DataProvider.Instance.ExecuteQuery(query, new object[] { "staff" });
            }
        }
    }
}
