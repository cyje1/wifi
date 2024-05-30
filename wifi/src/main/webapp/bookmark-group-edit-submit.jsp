<%@ page import="com.example.wifi.DB.ConnectDB" %><%--
  Created by IntelliJ IDEA.
  User: ckddy
  Date: 2024-05-29
  Time: 오후 9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
    <%
        String name = request.getParameter("name");
        int order = Integer.parseInt(request.getParameter("order"));
        int id = Integer.parseInt(request.getParameter("id"));

        ConnectDB connectDB = new ConnectDB();
        connectDB.updateBookmark(name, order, id);
    %>

    <script>
    window.onload = addBookmark;

    function addBookmark() {
        alert('북마크 그룹 정보를 수정하였습니다.');
        window.location.href = "http://localhost:8080/wifi_war_exploded/bookmark-group.jsp";
    }

    </script>
</body>
</html>
