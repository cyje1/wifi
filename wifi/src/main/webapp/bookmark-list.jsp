<%--
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

    <h1>북마크 그룹</h1>
    <a href="/wifi_war_exploded">홈 |</a>
    <a href="/wifi_war_exploded/history.jsp">위치 히스토리 목록 |</a>
    <a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기 |</a>
    <a href="/wifi_war_exploded/bookmark-list.jsp">북마크 보기 |</a>
    <a href="/wifi_war_exploded/bookmark-group.jsp">북마크 그룹 관리</a>

    <br/>
    <br/>

    <button type="button" onclick="addBookmark()">북마크 그룹 이름 추가</button>

    <script>
        function addBookmark() {
            window.location.href = "http://localhost:8080/wifi_war_exploded/bookmark-group-add.jsp";
        }
    </script>

</body>
</html>
