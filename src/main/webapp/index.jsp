<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Meu Primeiro JSP</title>
<link rel="stylesheet" href="CSS/styles.css">
</head>
<body>

<%
    try {
        String url = "jdbc:postgresql://localhost:5432/curso_java";
        String usuario = "postgres";
        String senha = "12345";

        Class.forName("org.postgresql.Driver"); 
        Connection conexao = DriverManager.getConnection(url, usuario, senha);

        String user = request.getParameter("usuario");
        String pass = request.getParameter("pass");

        if(user != "" && pass != "") {
            Statement st = conexao.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);   
            ResultSet rs = st.executeQuery("SELECT * FROM login WHERE log_usuario = '" + user + "' AND log_senha = '" + pass + "'");

            if(rs.next()) {
            	response.sendRedirect("hubSystem.html");
            }
        }

        conexao.close();
    } catch(ClassNotFoundException e) {
        out.println("<script>alert('Driver JDBC não encontrado: " + e.getMessage() + "');</script>");
    } catch(SQLException s) {
        out.println("<script>alert('Erro ao acessar o banco de dados: " + s.getMessage() + "');</script>");			
    }
%>

<form method="post" action="index.jsp">
	User: <input type="text" name="usuario"> 
	Password: <input type="password" name="pass">
	<button type="submit">Log in</button>
</form> 

</body>
</html>
