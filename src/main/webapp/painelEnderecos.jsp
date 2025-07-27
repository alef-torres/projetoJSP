<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="ISO-8859-1">
<title>Bairros</title>
<link rel="stylesheet" href="presetsStyles/painelEnderecosStyle.css">
</head>
<body>

	<h2>Manutenção bairros</h2>
	<button id="abrir-modal" class="novo-registro">Novo Registro</button>
	<button id="novo-registro" class="novo-registro"
		onclick="window.location.href='index.jsp'">Voltar login</button>
	<button class="novo-registro"
		onclick="window.location.href='hubSystem.html'">Voltar hub</button>

	<table class="table-bairros">
		<thead>
			<th>ID</th>
			<th>Nome</th>
			<th>Alterar</th>
			<th>Excluir</th>
		</thead>

		<tbody>
			<tr>
				<%
				try {
					String url = "jdbc:postgresql://localhost:5432/curso_java";
					String usuario = "SEU_USUARIO";
					String senha = "SUA_SENHA";

					Class.forName("org.postgresql.Driver");
					Connection conexao = DriverManager.getConnection(url, usuario, senha);
					Statement st = conexao.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
					
					if (request.getParameter("acao") != null) {
						st.executeUpdate("DELETE FROM bairro WHERE bai_codigo = " + request.getParameter("codigo"));
						response.sendRedirect("painelEnderecos.jsp");
					}
					
					ResultSet rs = st.executeQuery("SELECT * FROM bairro order by bai_codigo");

					while (rs.next()) {
				%>
			
			<tr>
				<td><%=rs.getString("bai_codigo")%></td>
				<td><%=rs.getString("bai_nome")%></td>
				<td><button class="btn-alterar"
						data-codigo="<%=rs.getString("bai_codigo")%>"
						data-usuario="<%=rs.getString("bai_nome")%>">
						Alterar</button></td>
				<td><button class="btn-excluir"
				onclick="window.location.href='painelEnderecos.jsp?acao=excluir&codigo=<%=rs.getString("bai_codigo")%>'">Excluir</button></td>
			</tr>
			<%
			}
			conexao.close();

			} catch (ClassNotFoundException e) {
			out.println(e);

			}
			%>

		</tbody>

	</table>

	<div id="modal-cadastro" class="modal">
		<div class="modal-content">
			<span class="fechar-cadastro">&times;</span>
			<h3>Novo Bairro</h3>
			<form method="post" action="painelEnderecos.jsp">
				<label for="id">ID</label><br> 
				<input type="number" id="id" name="bai_codigo" required><br> 
				<label for="usuario">Usuário:</label><br>
				<input type="text" id="name" name="bai_nome" required><br>
				<button type="submit">Cadastrar</button>
				<%
				if (request.getParameter("bai_codigo") != null) {

					try {
						int codigo = Integer.parseInt(request.getParameter("bai_codigo"));
						String user = request.getParameter("bai_nome");

						String url = "jdbc:postgresql://localhost:5432/curso_java";
						String usuario = "SEU_USUARIO";
						String senha = "SUA_SENHA";

						Class.forName("org.postgresql.Driver");
						Connection conexao = DriverManager.getConnection(url, usuario, senha);

						String sql = "INSERT INTO bairro (bai_codigo, bai_nome) VALUES (?, ?)";
						PreparedStatement ps = conexao.prepareStatement(sql);
						ps.setInt(1, codigo);
						ps.setString(2, user);

						ps.executeUpdate();
						conexao.close();

						out.println("<script>location.href='painelEnderecos.jsp';</script>");

					} catch (NumberFormatException e) {
						out.println("<script>alert('Erro ao converter dados numéricos.');</script>");
					} catch (Exception e) {
						out.println("<script>alert('Erro ao cadastrar: " + e.getMessage() + "');</script>");
					}
				}
				%>

			</form>
		</div>
	</div>
	
	<div id="modal-edicao" class="modal">
		<div class="modal-content">
			<span class="fechar-edicao">&times;</span>
			<h3>Editar bairro</h3>
			<form method="post" action="painelEnderecos.jsp">
				<label for="id">ID</label><br>
				<input type="text" id="codigo" name="bai_codigo"><br> 
				<label for="usuario">Nome</label><br> 
				<input type="text" id="usuario" name="bai_nome" required><br>  
				<button type="submit">Editar</button>
				<%
				if (request.getParameter("bai_codigo") != null) {
					try {
						int codigo = Integer.parseInt(request.getParameter("bai_codigo"));
						String user = request.getParameter("bai_nome");		

						Class.forName("org.postgresql.Driver");
						Connection conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/curso_java", "SEU_USUARIO",
								"SUA_SENHA");

						String sql = "UPDATE bairro SET (bai_codigo, bai_nome) VALUES (?, ?)";
						PreparedStatement ps = conexao.prepareStatement(sql);
						ps.setInt(1, codigo);
						ps.setString(2, user);

						ps.executeUpdate();
						conexao.close();

						out.println("<script>location.href='painelEnderecos.jsp';</script>");

					} catch (Exception e) {
						out.println("<script>alert('Erro ao atualizar: " + e.getMessage() + "');</script>");
					}
				}
				%>
			</form>
		</div>
	</div>

	<script>
  // Modal de cadastro
  const modalCadastro = document.getElementById("modal-cadastro");
  const btnAbrir = document.getElementById("abrir-modal");
  const fecharCadastro = document.querySelector(".fechar-cadastro");

  btnAbrir.onclick = function () {
    modalCadastro.style.display = "block";
  }

  fecharCadastro.onclick = function () {
    modalCadastro.style.display = "none";
  }

  // Modal de edição
  const modalEdicao = document.getElementById("modal-edicao");
  const fecharEdicao = document.querySelector(".fechar-edicao");

  document.querySelectorAll(".btn-alterar").forEach(botao => {
    botao.addEventListener("click", () => {
      document.getElementById("codigo").value = botao.dataset.codigo;
      document.getElementById("usuario").value = botao.dataset.usuario;
      modalEdicao.style.display = "block";
    });
  });

  fecharEdicao.onclick = function () {
    modalEdicao.style.display = "none";
  }

  window.onclick = function (event) {
    if (event.target === modalCadastro) {
      modalCadastro.style.display = "none";
    }
    if (event.target === modalEdicao) {
      modalEdicao.style.display = "none";
    }
  }
</script>

</body>
</html>