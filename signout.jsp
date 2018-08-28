<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<html>
    <head>
        <title>Blog</title>
        <link rel="stylesheet" type="text/css"href="conf.css">
        <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            a {
                text-decoration: underline;
                text-decoration-color: red;
            }
            a:hover {
                color: hotpink;
            }
            textarea {
                width: 260px;
                height: 400px;
                background-color: #3CBC8D;
            }
            * {
                font-size: 13px;
            }
        </style>
    </head>
    <body bgcolor="black">
    <center>
        <table width="550" bgcolor="white">
            <tr>
                <td align="left">
        <H1>Blog</h1>
        Signed out.
        <H6><a href="posts.jsp">Go Back</a></h6>
        <%
            session.invalidate();
        %>
                </td>
            </tr>
        </table>
    </center>
    </body>
</html>