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
    <title> 와이파이 정보 구하기 </title>
</head>
<body>
    <h1> 히스토리 삭제 </h1>
    <a href="/wifi_war_exploded">홈 |</a>
    <a href="/wifi_war_exploded/history.jsp">위치 히스토리 목록 |</a>
    <a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
    <a href="/wifi_war_exploded/bookmark-list.jsp">북마크 보기 |</a>
    <a href="/wifi_war_exploded/bookmark-group.jsp">북마크 그룹 관리</a>

    <%
       String id = request.getParameter("id");

        ConnectDB connectDB = new ConnectDB();
        connectDB.deleteHistory(Integer.parseInt(id));
    %>
    <p> <%=id%>번 히스토리 삭제가 완료 되었습니다. </p>

</body>
</html>
