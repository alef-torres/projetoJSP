<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<title>Manutenção usuários</title>
<head>
<meta charset="UTF-8">
<title>Manutenção usuários</title>
<link rel="stylesheet" href="presetsStyles/paineUserslStyle.css">
</head>

</head>
<body>

	<h2>Manutenção usuários</h2>

	<button id="abrir-modal" class="novo-registro">Novo Registro</button>
	<button id="novo-registro" class="novo-registro"
		onclick="window.location.href='index.jsp'">Voltar login</button>
	<button class="novo-registro" onclick="window.location.href='hubSystem.html'">Voltar hub</button>

	<table class="tabela-usuarios">
		<thead>
			<tr>
				<th>id</th>
				<th>Nome do Usuário</th>
				<th>Senha</th>
				<th>Nível de acesso</th>
				<th>Alterar</th>
				<th>Excluir</th>
			</tr>
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
						st.executeUpdate("DELETE FROM login WHERE log_codigo = " + request.getParameter("codigo"));
						response.sendRedirect("painelUsers.jsp");
					}

					ResultSet rs = st.executeQuery("SELECT * FROM login order by log_codigo");

					while (rs.next()) {
				%>
			
			<tr>
				<td><%=rs.getString("log_codigo")%></td>
				<td><%=rs.getString("log_usuario")%></td>
				<td><%=rs.getString("log_senha")%></td>
				<td><%=rs.getString("log_nivelacesso")%></td>
				<td><button class="btn-alterar"
						data-codigo="<%=rs.getString("log_codigo")%>"
						data-usuario="<%=rs.getString("log_usuario")%>"
						data-senha="<%=rs.getString("log_senha")%>"
						data-nivel="<%=rs.getString("log_nivelacesso")%>">
						Alterar</button></td>
				<td><button class="btn-excluir"
				onclick="window.location.href='painelUsers.jsp?acao=excluir&codigo=<%=rs.getString("log_codigo")%>'">Excluir</button></td>
			</tr>
			<%
			}

			conexao.close();
			} catch (ClassNotFoundException e) {
			out.println("<script>alert('Driver JDBC não encontrado: " + e.getMessage() + "');</script>");
			} catch (SQLException s) {
			out.println("<script>alert('Erro ao acessar o banco de dados: " + s.getMessage() + "');</script>");
			}
			%>

			</tr>
		</tbody>
	</table>

	<div id="modal-edicao" class="modal">
		<div class="modal-content">
			<span class="fechar-edicao">&times;</span>
			<h3>Editar usuário</h3>
			<form method="post" action="painelUsers.jsp">
				<input type="hidden" id="codigo" name="log_codigo"> <label
					for="usuario">Usuário:</label><br> <input type="text"
					id="usuario" name="log_usuario" required><br> <label
					for="senha">Senha:</label><br> <input type="password"
					id="senha" name="log_senha" required><br> <label
					for="nivel">Nível de Acesso:</label><br> <input type="number"
					id="nivel" name="log_nivelacesso" required><br>

				<button type="submit">Editar</button>
				<%
				if (request.getParameter("log_codigo") != null) {
					try {
						int codigo = Integer.parseInt(request.getParameter("log_codigo"));
						String user = request.getParameter("log_usuario");
						String pass = request.getParameter("log_senha");
						int nivel = Integer.parseInt(request.getParameter("log_nivelacesso"));

						Class.forName("org.postgresql.Driver");
						Connection conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/curso_java", "SEU_USUARIO",
						"SUA_SENHA");

						String sql = "UPDATE login SET log_usuario=?, log_senha=?, log_nivelacesso=? WHERE log_codigo=?";
						PreparedStatement ps = conexao.prepareStatement(sql);
						ps.setString(1, user);
						ps.setString(2, pass);
						ps.setInt(3, nivel);
						ps.setInt(4, codigo);

						ps.executeUpdate();
						conexao.close();

						out.println("<script>location.href='painelUsers.jsp';</script>");

					} catch (Exception e) {
						out.println("<script>alert('Erro ao atualizar: " + e.getMessage() + "');</script>");
					}
				}
				%>
			</form>
		</div>
	</div>


	<div id="modal-cadastro" class="modal">
		<div class="modal-content">
			<span class="fechar-cadastro">&times;</span>
			<h3>Novo Usuário</h3>
			<form method="post" action="painelUsers.jsp">
				<label for="id">ID</label><br> <input type="number" id="id"
					name="log_codigo" required><br> <label for="usuario">Usuário:</label><br>
				<input type="text" id="usuario" name="log_usuario" required><br>

				<label for="senha">Senha:</label><br> <input type="password"
					id="senha" name="log_senha" required><br> <label
					for="nivel">Nível de Acesso:</label><br> <input
					type="nivel_acesso" id="nivel_acesso" name="log_nivelacesso"
					required><br>
				<button type="submit">Cadastrar</button>
				<%
				if (request.getParameter("log_codigo") != null) {

					try {
						int codigo = Integer.parseInt(request.getParameter("log_codigo"));
						String user = request.getParameter("log_usuario");
						String pass = request.getParameter("log_senha");
						int nivel = Integer.parseInt(request.getParameter("log_nivelacesso"));

						String url = "jdbc:postgresql://localhost:5432/curso_java";
						String usuario = "SEU_USUARIO";
						String senha = "SUA_SENHA";

						Class.forName("org.postgresql.Driver");
						Connection conexao = DriverManager.getConnection(url, usuario, senha);

						String sql = "INSERT INTO login (log_codigo, log_usuario, log_senha, log_nivelacesso) VALUES (?, ?, ?, ?)";
						PreparedStatement ps = conexao.prepareStatement(sql);
						ps.setInt(1, codigo);
						ps.setString(2, user);
						ps.setString(3, pass);
						ps.setInt(4, nivel);

						ps.executeUpdate();
						conexao.close();

						out.println("<script>location.href='painelUsers.jsp';</script>");

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
      document.getElementById("senha").value = botao.dataset.senha;
      document.getElementById("nivel").value = botao.dataset.nivel;

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
