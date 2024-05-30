<%@ page import="com.example.wifi.DB.ConnectDB" %><%--
  Created by IntelliJ IDEA.
  User: ckddy
  Date: 2024-05-30
  Time: 오후 9:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
    <%
        int bookmarkId = Integer.parseInt(request.getParameter("bookmark-id"));
        String bookmarkName = request.getParameter("bookmark-name");
        String wifiName = request.getParameter("wifi-name");

        ConnectDB connectDB = new ConnectDB();
        connectDB.addToBookmark(bookmarkId, bookmarkName, wifiName);
    %>

    <script>
        window.onload = addBookmark;

        function addBookmark() {
            alert('북마크 정보를 추가하였습니다.');
            window.location.href = "http://localhost:8080/wifi_war_exploded/bookmark-list.jsp";
        }
    </script>

</body>
</html>
