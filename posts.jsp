<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<html>
    <head>
        <title>Posts</title>
        <link rel="stylesheet" type="text/css"href="conf.css">
        <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            a {
                text-decoration: none;
                text-decoration-color: red;
            }
            a:hover {
                color: hotpink;
            }
            * {
                font-size: 13px;
            }
        </style>
        <script>
            function deletePost(id) {
                if(confirm("Delete post no. " + id + "?")) {
                    var form = document.getElementById("deleteFrm");
                    form.id.value = id;
                    form.submit();
                }
            }
        </script>
    </head>
    <%
    String email = (String) session.getAttribute("email");
    %>
    <body bgcolor="black">
    <center>
        <table width="550" bgcolor="white">
            <tr>
                <td align="center">
        <form id="deleteFrm" method="post" action="deletePost.jsp">
            <input type="hidden" name="id">
        </form>
        <img src="banner.gif">
        <H1>Blog</h1>
        <div style="width:350px;float:left"><H3>Posts</H3></div>
        <%
        if(email == null) {
        %>
        <div style="height:40px;margin-top:20px"><a href="signup.jsp">Sign Up</a> | <a href="signin.jsp">Sign In</a></div>
        <%
        } else {
        %>
        <div style="height:40px;margin-top:20px">Hi <%=email%>! | <a href="signout.jsp">Sign Out</a></div>
        <%
        }
        String search = request.getParameter("search");
        if(search == null) {
            search = "";
        }
        %>
        <H6><a href="insert.jsp">Do Post</a></h6>
        <HR align="left" style="width:550px"/>
        <table width="550">
                <%
                String hostName = "ec2-54-163-240-54.compute-1.amazonaws.com";
                String dbName = "d89l9begjikklj";
                String userName = "isscllglmxgeln";
                String password = "334f696049572d4bc9c3b6b78c3410301e24dd3b5fd2b96dc15bf4c1c6fed113";
                
                Connection conn = null;

                try {
                    Class.forName("org.postgresql.Driver");
                    String url = "jdbc:postgresql://" + hostName + "/" + dbName + "?user=" + userName + "&password=" + password + "&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
                    conn = DriverManager.getConnection(url);
                } catch(Exception e) {out.println(e.getMessage());}

                try {
                
                    if(conn != null) {
                        int pg = 1;
                        int offset = 0;
                        if(request.getParameter("pg") == null) {
                            pg = 1;
                            offset = 0;
                        } else {
                            pg = Integer.parseInt(request.getParameter("pg"));
                            offset = (pg-1) * 3;
                        }
                        Statement st = conn.createStatement();
                        String sq = "select id, email, title, post, inputdate from blog order by id desc";
                        if(search != null) {
                            if(!search.equals("")) {
                                sq = "select id, email, title, post, inputdate from blog where title like '%" + search + "%' or post like '%" + search + "%' order by id desc;";
                            }
                        }
                        ResultSet rs = st.executeQuery(sq);
                        while(rs.next()) {
                        %>
                        <tr>
                            <td width="150">
                                <%=rs.getString("email")%>
                            </td>
                            <td width="250">
                                <%=rs.getString("title")%>
                            </td>
                            <td width="100">
                                <%=rs.getString("inputdate")%>
                            </td>
                            <td width="50">
                                <%
                                if(email != null) {
                                    if(email.equals(rs.getString("email"))) {
                                    %>
                                    <a href="editPost.jsp?id=<%=rs.getInt("id")%>"><img width="20" height="20" src="pen.jpg"></a>
                                    <a href="javascript:deletePost(<%=rs.getInt("id")%>)"><img width="20" height="20" src="delete.png"></a>
                                    <%
                                    }
                                }
                                %>
                            </td>
                        </tr>
                        <tr><td colspan="5"><hr></td></tr>
                        <tr>
                            <td colspan="5">
                                <%=rs.getString("post")%>
                            </td>
                        </tr>
                        <tr><td colspan="5"><hr></td></tr>
                        <tr><td colspan="5"><hr></td></tr>
                        <%
                        }
                    }
                } catch(Exception e) {}
                %>
                <%
                if(conn != null) {
                    try {
                        conn.close();
                    } catch(Exception e) {}
                }
                %>
        </table>
        <br><br>
        </td>
            </tr>
        </table>
        <h5 style="color:white">&copy; 2018 All Rights Reserved</h5>
    </center>
    </body>
</html>