<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page1.aspx.cs" Inherits="Lab8.Page1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
           <title>Лабораторная работа 8(1)</title>
            <style type="text/css">
                    #TextArea1 {
                        height: 108px;
                        width: 228px;
                    }
                    h3 {
                        font-family: Verdana, Arial, Helvetica, sans-serif;
                    } 
                    p {
                        font-family: 'Times New Roman', Times, serif;
                        font-style: italic;
                        font-size: 20px;
                    }
                    .flex-container {
                        display: flex;
                        flex-direction: column;
                        width: 100%;
                    }
                    .center {
                        align-items: center;
                    }
                    .flex-start
                    {
                        align-items: flex-start;
                    }
            </style>
    </head>
    <body>
        <form id="form2" runat="server">
            <div class="flex-container">
                <div class="flex-container center">
                    <p>
                        <a href="Page2.aspx">Запрос 2</a><br />
                        <label>Запрос 1</label>
                    </p>
                    <h3>Получить информацию о размере издержек на изготовление указанного изделия на заданную дату.</h3>
                </div>
                <div class="flex-container center">
                    <asp:GridView
                        ID="GridView1"
                        runat="server" Height="133px" Width="411px">
                    </asp:GridView>
                </div>
                <h4 style="width: 185px">Укажите изделие:</h4>
                <asp:DropDownList
                    ID="DropDownList1"
                    runat="server"
                    DataSourceID="SqlDataSource1"
                    DataTextField="n_izd"
                    DataValueField="n_izd" Height="30px" Width="200px">
                </asp:DropDownList>

                <asp:SqlDataSource
                    ID="SqlDataSource1"
                    runat="server"
                    ConnectionString="<%$ ConnectionStrings:studentsConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:studentsConnectionString.ProviderName %>"
                    SelectCommand="SELECT n_izd FROM pmib8306.j ORDER BY n_izd"></asp:SqlDataSource>
                <h4 style="width: 184px">Укажите дату:</h4>
                <asp:TextBox
                    ID="TextBox1"
                    runat="server"
                    TextMode="Date"
                    OnTextChanged="TextBox1_TextChanged" Height="30px" Width="200px"></asp:TextBox>
                <br />
                <br />
                <table style="width: 100%; height: 59px; color: red;">
                    <tr>
                        <td>
                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator1"
                                runat="server"
                                ControlToValidate="Textbox1"
                                ErrorMessage="Поле 'Дата' пусто - заполните!"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label
                                ID="Label1"
                                runat="server"
                                Text="">
                            </asp:Label>
                        </td>
                    </tr>
                </table>
                <div class="flex-container center">
                    <asp:Button
                        ID="Button1"
                        runat="server"
                        OnClick="Button1_Click"
                        Text="Выполнить" BorderColor="#99FF33" CssClass="center" Height="55px" Width="255px"></asp:Button>
                </div>
                <br />
                <br />
                <br />
            </div>
        </form>
    </body>
</html>
