<%@ page import="com.example.wifi.DB.ConnectDB" %>
<%@ page import="com.example.wifi.Dto.BookmarkListDto" %><%--
  Created by IntelliJ IDEA.
  User: ckddy
  Date: 2024-05-30
  Time: 오후 8:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0; /* 상하 여백만 남기고 좌우 여백 제거 */
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        td:first-child {
            background-color: #4CAF50;
            color: white;
            width: 30%;
        }
        td:nth-child(2) {
            background-color: #f2f2f2;
            width: 70%;
        }
        tr:nth-child(even) td:nth-child(2) {
            background-color: white;
        }
        a {
            text-align: center;
        }
        .form-container {
            text-align: center; /* 버튼을 왼쪽으로 정렬 */
        }
    </style>
</head>

<body>
    <h1>북마크 삭제</h1>
    <a href="/wifi_war_exploded">홈 |</a>
    <a href="/wifi_war_exploded/history.jsp">위치 히스토리 목록 |</a>
    <a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기 |</a>
    <a href="/wifi_war_exploded/bookmark-list.jsp">북마크 보기 |</a>
    <a href="/wifi_war_exploded/bookmark-group.jsp">북마크 그룹 관리</a>

    <br/>

    <p>북마크를 삭제하시겠습니까?</p>

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        String wifiName = request.getParameter("wifi-name");

        ConnectDB connectDB = new ConnectDB();
        BookmarkListDto bookmarkListDto = connectDB.selectBookmarkListWithId(id, wifiName);
    %>

    <table>
        <tr>
            <td>북마크 이름</td>
            <td><%=bookmarkListDto.getBookmarkName()%></td>
        </tr>
        <tr>
            <td>와이파이명</td>
            <td><%=bookmarkListDto.getWifiName()%></td>
        </tr>
        <tr>
            <td>등록일자</td>
            <td><%=bookmarkListDto.getRegisteredDate()%></td>
        </tr>
    </table>

    <div class="form-container">
        <div class="links">
            <a href="/wifi_war_exploded/bookmark-list.jsp">돌아가기</a> |
            <button type="button" onclick="deleteBookmarkList()">삭제</button>
        </div>
    </div>


    <script>
        function deleteBookmarkList() {
            window.location.href = "http://localhost:8080/wifi_war_exploded/bookmark-list-delete-submit.jsp" +
                "?id=<%=bookmarkListDto.getId()%>&wifi-name=<%=bookmarkListDto.getWifiName()%>";
        }
    </script>

</body>
</html>
