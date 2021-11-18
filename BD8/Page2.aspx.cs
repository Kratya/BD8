using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.Odbc;
using System.Data.SqlClient;

namespace Lab8
{
    public partial class Page2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //создание объекта подключения и ODBC-источник
            OdbcConnection connection = new OdbcConnection(@"Dsn=PostgreSQL30");
            connection.Open();

            //текст запроса
            string request = "insert into pmib8306.e values('E'||trim(to_char(nextval('table_izd_seq'),'99999')), ?, ?, ?)";

            //"create sequence table_izd_seq increment by 1 start with 14;
            using (OdbcCommand command = new OdbcCommand(request, connection))
            {
                string izd = DropDownList1.SelectedValue;
                string cost = Cost.Text;
                string date = BDate.Text;

                //параметры
                command.Parameters.AddWithValue("@izd", izd);
                command.Parameters.AddWithValue("@date", date);
                command.Parameters.AddWithValue("@cost", Int32.Parse(cost));
                //объявление объекта транзакции
                OdbcTransaction tx = null;

                try
                {
                    //созданиетранзакции и извлечение объекта транзакции из объекта подключения
                    tx = connection.BeginTransaction();
                    //объект SQL-команды в транзакцию
                    command.Transaction = tx;
                    int i = command.ExecuteNonQuery();
                    //подтверждение транзакции
                    tx.Commit();
                    //сообщение об успешности транзакции и количестве обработанных записей
                    Label1.Text = "Транзакция успешно завершена. Записей обработано: " + i.ToString() + ".\n";
                    if (i == 0) Label1.Text += "Запрос - пуст.\n";
                }
                catch (Exception exec)
                {
                    //сообщение об ошибке + текст ошибки
                    Label1.Text = "Транзакция не завершена. Ошибка: " + exec.Message + ".\n";
                    //откат транзакции
                    tx.Rollback();
                }
            }
        }
        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
        }
    }
}
