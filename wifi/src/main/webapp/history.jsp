<%@ page import="com.example.wifi.Dto.HistoryDto" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.wifi.DB.ConnectDB" %><%--
  Created by IntelliJ IDEA.
  User: ckddy
  Date: 2024-05-28
  Time: 오후 8:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> 와이파이 정보 구하기 </title>
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
    <h1> 위치 히스토리 목록 </h1>

    <a href="/wifi_war_exploded">홈 |</a>
    <a href="/wifi_war_exploded/history.jsp">위치 히스토리 목록 |</a>
    <a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기 |</a>
    <a href="/wifi_war_exploded/bookmark-list.jsp">북마크 보기 |</a>
    <a href="/wifi_war_exploded/bookmark-group.jsp">북마크 그룹 관리</a>

    <br/>
    <br/>

    <div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>X좌표</th>
                    <th>Y좌표</th>
                    <th>조회일자</th>
                    <th>비고</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <%
                        ConnectDB connectDB = new ConnectDB();
                        List<HistoryDto> list = connectDB.selectHistory();

                        for (int i = list.size() - 1; i >= 0; i--) {


                    %>
                    <td> <%= list.get(i).getId() %> </td>
                    <td> <%= list.get(i).getX() %> </td>
                    <td> <%= list.get(i).getY() %> </td>
                    <td> <%= list.get(i).getDate() %> </td>
                    <td> <a href="/wifi_war_exploded/history-delete.jsp?id=<%=list.get(i).getId()%>"> 삭제 </a> </td>
                </tr>
                    <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
