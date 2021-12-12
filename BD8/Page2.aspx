<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page2.aspx.cs" Inherits="Lab8.Page2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
         <title>Лабораторная работа 8(2)</title>
            <style type="text/css">
                    #TextArea1 {
                        height: 108px;
                        width: 228px;<asp:SqlDataSource runat="server"></asp:SqlDataSource>
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
        <form id="form1" runat="server">
            <div class="flex-container">
                <div class="flex-container center">
                    <p>
                        <a href="Page1.aspx">Запрос 1</a><br />
                        <label>Запрос 2</label>
                    </p>
                    <h3>В таблицу издержек добавить новую запись c заданными значениями номера изделия, размера издержек и даты начала действия.</h3>
                </div>
                <div class="flex-container flex-start">
                    <br />
                    <h4>Укажите изделие:</h4>
                    <asp:DropDownList 
                        ID="DropDownList1" 
                        runat="server"
                        DataSourceID="SqlDataSource1"
                         DataTextField="nameTown"
                         DataValueField="n_izd" Height="30px" Width="200px">
                    </asp:DropDownList>

                    <asp:SqlDataSource
                        ID="SqlDataSource1"
                        runat="server"
                        ConnectionString="<%$ ConnectionStrings:studentsConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:studentsConnectionString.ProviderName %>"
                        SelectCommand="SELECT n_izd, CONCAT_WS(' - ', name, town) AS nameTown FROM pmib8306.j"></asp:SqlDataSource>
                    <br />
                    <br />
                    <h4>Укажите размер издержек</h4>
                    <asp:TextBox
                        ID="Cost"
                        runat="server" Height="30px" Width="200px"></asp:TextBox>
                    <br />
                    <br />
                    <h4>Укажите дату начала действия</h4>
                    <asp:TextBox
                        ID="BDate"
                        runat="server"
                        TextMode="Date"
                        OnTextChanged="TextBox1_TextChanged" Height="30px" Width="200px"></asp:TextBox>
                    <br />
                    <br />
                    <table style="width: 100%; height: 100px; color: red;">
                        <tr>
                            <td>
                                <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator1"
                                    runat="server"
                                    ControlToValidate="Cost"
                                    Display="Dynamic"
                                    ErrorMessage="Поле 'Размер издержек' не должно быть пустым">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator2"
                                    runat="server"
                                    ControlToValidate="BDate"
                                    Display="Dynamic"
                                    ErrorMessage="Поле 'Дата начала действия' не должно быть пустым">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RangeValidator
                                    ID="RangeValidator1"
                                    runat="server"
                                    ControlToValidate="Cost"
                                    ErrorMessage="Поле 'Размер издержек' должнобыть в промежутке от 0 до 1000"
                                    MaximumValue="1000"
                                    MinimumValue="0"
                                    Type="Integer">
                                </asp:RangeValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label
                                    ID="Label1"
                                    runat="server">
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
                </div>
            </div>
        </form>
    </body>
</html>
