<%@ page import="com.example.wifi.DB.ConnectDB" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.wifi.Dto.BookmarkDto" %><%--
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
        table{
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid lightgray;
            padding: 6px;
            text-align: center;
        }
        thead th {
            background-color: #4CAF50;
            color: white;
        }
        tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tbody tr:nth-child(odd) {
            background-color: #ffffff;
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

    <button type="button" onclick="addBookmark()">북마크 그룹 이름 추가</button>

    <br/>
    <br/>

    <div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>북마크 이름</th>
                    <th>순서</th>
                    <th>등록일자</th>
                    <th>수정일자</th>
                    <th>비고</th>
                </tr>
            </thead>
            <tbody>
                    <%
                        ConnectDB connectDB = new ConnectDB();
                        List<BookmarkDto> list = connectDB.selectBookmark();

                        if (!list.isEmpty()) {
                            for (int i = 0; i < list.size(); i++) {
                    %>
                <tr>
                    <td><%= list.get(i).getId() %> </td>
                    <td><%= list.get(i).getName()%> </td>
                    <td><%= list.get(i).getOrder()%> </td>
                    <td><%= list.get(i).getRegisteredDate()%> </td>

                    <% if (list.get(i).getUpdatedDate() != null) { %>
                    <td> <%=list.get(i).getUpdatedDate() %> </td>
                    <%  } else { %>
                    <td> </td>
                    <% }%>
                    
                    <td><a href="/wifi_war_exploded/bookmark-group-edit.jsp?id=<%=list.get(i).getId()%>&name=<%=list.get(i).getName()%>&order=<%=list.get(i).getOrder()%>">수정</a>
                        <a href="/wifi_war_exploded/bookmark-group-delete.jsp?id=<%=list.get(i).getId()%>&name=<%=list.get(i).getName()%>&order=<%=list.get(i).getOrder()%>">삭제</a></td>
                </tr>
                    <%   } } else {    %>
                <td colspan="20">
                    <br/>
                    정보가 존재하지 않습니다.
                    <br/>
                    <br/>
                </td>
                <% } %>
            </tbody>
        </table>
    </div>

    <script>
    function addBookmark() {
        window.location.href = "http://localhost:8080/wifi_war_exploded/bookmark-group-add.jsp";
    }
    </script>



</body>
</html>
