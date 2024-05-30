<%--
  Created by IntelliJ IDEA.
  User: ckddy
  Date: 2024-05-30
  Time: 오후 7:00
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
<h1>북마크 그룹 수정</h1>
<a href="/wifi_war_exploded">홈 |</a>
<a href="/wifi_war_exploded/history.jsp">위치 히스토리 목록 |</a>
<a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기 |</a>
<a href="/wifi_war_exploded/bookmark-list.jsp">북마크 보기 |</a>
<a href="/wifi_war_exploded/bookmark-group.jsp">북마크 그룹 관리</a>

<br/>
<br/>

<% int id = Integer.parseInt(request.getParameter("id")); %>

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
    <div class="links">
        <a href="/wifi_war_exploded/bookmark-group.jsp">돌아가기</a> |
        <button type="button" onclick="deleteBookmark()">삭제</button>
    </div>
</div>

<script>
    function deleteBookmark() {
        window.location.href = "http://localhost:8080/wifi_war_exploded/bookmark-group-delete-submit.jsp" +
            "?id=" + <%=id%>;
    }

    function initializeFields() {
        const beforeEditName = getUrlParameter('name');
        const beforeEditOrder = getUrlParameter('order');

        document.getElementById('bookmarkName').value = beforeEditName;
        document.getElementById('order').value = beforeEditOrder;
    }

    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    window.onload = initializeFields;
</script>

</body>
</html>
