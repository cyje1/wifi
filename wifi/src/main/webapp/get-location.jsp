<%--
  Created by IntelliJ IDEA.
  User: ckddy
  Date: 2024-05-28
  Time: 오후 4:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> 좌표에 따른 위치 구하기 </title>
</head>
<body>
    <%
        double lat = Double.parseDouble(request.getParameter("latitude"));
        double lnt = Double.parseDouble(request.getParameter("longitude"));

        System.out.println(lat);
        System.out.println(lnt);
    %>

    <a href="/wifi_war_exploded">홈으로 가기</a>
</body>
</html>
