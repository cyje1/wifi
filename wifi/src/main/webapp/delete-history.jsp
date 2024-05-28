<%@ page import="com.example.wifi.DB.ConnectDB" %><%--
  Created by IntelliJ IDEA.
  User: ckddy
  Date: 2024-05-28
  Time: 오후 9:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> 히스토리 삭제 </title>
</head>
<body>
    <h1> 히스토리 삭제 </h1>
    <a href="/wifi_war_exploded">홈 |</a>
    <a href="/wifi_war_exploded/history.jsp">위치 히스토리 목록 </a>

    <%
       String id = request.getParameter("id");

        ConnectDB connectDB = new ConnectDB();
        connectDB.deleteHistory(Integer.parseInt(id));
    %>
    <p> <%=id%>번 히스토리 삭제가 완료 되었습니다. </p>

</body>
</html>
