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
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0; /* 좌우 여백 제거하여 왼쪽 정렬 */
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
        input[type="text"] {
            width: 95%;
            padding: 5px;
            margin: 5px 0;
            box-sizing: border-box;
        }
        .form-container {
            text-align: center; /* 버튼을 왼쪽으로 정렬 */
        }

    </style>
</head>
<body>
    <h1>북마크 그룹 추가</h1>
    <a href="/wifi_war_exploded">홈 |</a>
    <a href="/wifi_war_exploded/history.jsp">위치 히스토리 목록 |</a>
    <a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기 |</a>
    <a href="/wifi_war_exploded/bookmark-list.jsp">북마크 보기 |</a>
    <a href="/wifi_war_exploded/bookmark-group.jsp">북마크 그룹 관리</a>

    <br/>
    <br/>

    <table>
        <tr>
            <td>북마크 이름</td>
            <td><input type="text" id="bookmarkName" name="bookmarkName"></td>
        </tr>
        <tr>
            <td>순서</td>
            <td><input type="text" id="order" name="order"></td>
        </tr>
    </table>

    <div class="form-container">
        <button type="button" onclick="addBookmark()">추가</button>
    </div>

    <script>
        function addBookmark() {
            const bookmarkName = document.getElementById('bookmarkName').value;
            const order = document.getElementById('order').value;

            window.location.href = "http://localhost:8080/wifi_war_exploded/bookmark-group-submit.jsp" +
                "?name=" + bookmarkName + "&order=" + order;
        }
    </script>

</body>
</html>
