<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<html>
    <head>
        <title>Edit Post</title>
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
            textarea {
                width: 460px;
                height: 400px;
            }
            input[type=text] {
                width: 250px;
                padding: 12px 20px;
                margin: 8px 0;
                box-sizing: border-box;
            }
            * {
                font-size: 13px;
            }
        </style>
    </head>
    <%
    String email = (String) session.getAttribute("email");
    %>
    <body bgcolor="black">
    <center>
        <table width="550" bgcolor="white">
            <tr>
                <td align="left">
        <H1>Blog</h1>
        <div style="width:350px;float:left"><H3>Edit Post</H3></div>
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
        %>
        <H6><a href="posts.jsp">Go Back</a></h6>
        <HR align="left" style="width:550px"/>
        <form method="post" action="editPost.jsp">
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

                String id = request.getParameter("id");
                String titl = "";
                String pos = "";
                
                try {
                    
                    Statement st = conn.createStatement();
                    String strSql = "select title, post from blog where email = '" + email + "' and id = " + id;
                
                    ResultSet rs = st.executeQuery(strSql);
                    if(rs.next()) {
                        titl = rs.getString("title");
                        pos = rs.getString("post");
                        titl = titl.replaceAll("\"", "\\\"");
                        pos = pos.replaceAll("<br />", "\r\n");
                        pos = pos.replaceAll("<br>", "\r\n");
                        pos = pos.replaceAll("<BR>", "\r\n");
                        pos = pos.replaceAll("<BR />", "\r\n");
                    %>
                        Title: <input type="text" name="title" value="<%=titl%>"><BR />
                        Post: <textarea name="post"><%=pos%></textarea><BR />
                        <input type="hidden" name="id" value="<%=id%>"><BR />
                        Date: <%=((new java.util.Date()).getMonth()+1) + "-" + (new java.util.Date()).getDate() + "-" + (new java.util.Date()).getYear()%>
                    <%
                    }
                    
                } catch(Exception e) {out.println(e.getMessage());}

                try {
                
                    if(conn != null) {
                        
                        if(id != null && request.getParameter("title") != null) {
                    
                            String title = request.getParameter("title");
                            String post = request.getParameter("post");
                            post = post.replaceAll("\r\n", "<br />");
                            Statement st = conn.createStatement();
                            
                            st.execute("update blog set title = '"+title+"', post = '"+post+"', inputdate = now() where email = '" + email + "' and id = " + id + ";");
                            %>
                            <BR />
                            Post edited.
                            <%
                        }
                    } else {
                            %>connection is null<% 
                    }
                } catch(Exception e) {%><%=e.getMessage()%><%}
                %>
                <%
                if(conn != null) {
                    if(!conn.isClosed()) {
                        try {

                            conn.close();

                        } catch(Exception e) {}
                    }
                }
                %><BR /><BR /><BR />
                <%
                if(email == null) {
                %>
                <input type="submit" value="Edit post." disabled="true"><br/>
                <%
                } else {
                %>
                <input type="submit" value="Edit post."><br/>
                <%
                }
                %>
        </form>
                </td>
            </tr>
        </table>
    </center>
    </body>
</html>