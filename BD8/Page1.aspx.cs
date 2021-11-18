using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Web.UI.WebControls;
using System.Data.Odbc;
using System.Data.SqlClient;

namespace Lab8
{
    //структура запроса
    public class Struct_query
    {
        public string n_exp { get; set; }
        public string n_izd { get; set; }
        public DateTime date_begin { get; set; }
        public int cost { get; set; }
        public Struct_query(string n_exp, string n_izd, DateTime date_begin, int cost)
        {
            this.n_exp = n_exp;
            this.n_izd = n_izd;
            this.date_begin = date_begin;
            this.cost = cost;
        }
    }

    public partial class Page1 : System.Web.UI.Page
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
            string request = "select pmib8306.e.* " +
                             "from pmib8306.e " +
                             "where pmib8306.e.n_izd = ? " +
                                   "and " +
                                   "pmib8306.e.date_begin = ? ";

            using (OdbcCommand command = new OdbcCommand(request, connection))
            {
                //изделие, дата
                string izd = DropDownList1.SelectedValue;
                string dateFrom = TextBox1.Text;
                //параметры
                command.Parameters.AddWithValue("@izd", izd);
                command.Parameters.AddWithValue("@date", dateFrom);
                //объявление объекта транзакции
                OdbcTransaction tr = null;

                try
                {
                    //создание транзакции и извлечение объекта транзакции из объекта подключения
                    tr = connection.BeginTransaction();

                    //объект SQL-команды в транзакцию
                    command.Transaction = tr;
                    //запрос
                    OdbcDataReader reader = command.ExecuteReader();
                    //возвращенный запрос в список
                    List<Struct_query> data = new List<Struct_query>();
                    while (reader.Read())
                        data.Add(new Struct_query((string)reader.GetValue(0),
                                                    (string)reader.GetValue(1),
                                                    (DateTime)reader.GetValue(2),
                                                    (int)reader.GetValue(3)));
                    //закрытие запроса
                    reader.Close();
                    //подтверждение транзакции
                    tr.Commit();
                    //сообщение об успешности транзакции и количестве обработанных записей
                    //или так data.Count().ToString();
                    int i = command.ExecuteNonQuery();
                    Label1.Text = "Транзакция успешно завершена. Записей обработано: " + i.ToString() + ".\n";
                    if (i == 0) Label1.Text += "Запрос - пуст.\n";
                    //обновить grid с новыми данными
                    GridView1.DataSource = data;
                    GridView1.DataBind();

                }
                catch (Exception exec)
                {
                    //сообщение об ошибке + текст ошибки
                    Label1.Text = "Транзакция не завершена. Ошибка: " + exec.Message + ".\n";
                    //откат транзакции
                    tr.Rollback();
                }
            }
            //закрыть соединение
            connection.Close();

        }
        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
        }
    }
}
