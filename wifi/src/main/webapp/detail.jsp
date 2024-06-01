<%@ page import="com.example.wifi.DB.ConnectDB" %>
<%@ page import="com.example.wifi.Dto.WifiDto" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.wifi.Dto.BookmarkDto" %><%--
  Created by IntelliJ IDEA.
  User: ckddy
  Date: 2024-05-29
  Time: 오후 8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> 와이파이 정보 구하기 </title>
    <style>
        table {
            width: 50%;
            border-collapse: collapse;
            margin: 20px 0; /* 상하 여백만 남기고 좌우 여백 제거 */
        }

        th, td {
            border: 1px solid lightgray;
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
        }

        td:nth-child(2) {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) td:nth-child(2) {
            background-color: white;
        }
    </style>
</head>
<body>
    <h1>와이파이 정보 구하기</h1>
    <a href="/wifi_war_exploded">홈 |</a>
    <a href="/wifi_war_exploded/history.jsp">위치 히스토리 목록 |</a>
    <a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기 |</a>
    <a href="/wifi_war_exploded/bookmark-list.jsp">북마크 보기 |</a>
    <a href="/wifi_war_exploded/bookmark-group.jsp">북마크 그룹 관리</a>

    <br/>
    <select id="bookmark">
        <option>북마크 이름 선택</option>
        <%
            ConnectDB connectDB = new ConnectDB();
            List<BookmarkDto> list = connectDB.selectBookmark();


            for (int i = 0; i < list.size(); i++) {
        %>
        <option value="<%=list.get(i).getId()%>" name="<%=list.get(i).getName()%>"><%=list.get(i).getName()%></option>
        <%
            }
        %>
    </select>
    <button type="button" onclick="addToBookmark()">북마크 추가하기</button>

    <br/>

    <div>
        <%
            WifiDto wifiDto = connectDB.selectWifiWithNo(request.getParameter("mgrNo"),
            Double.parseDouble(request.getParameter("lat")),
            Double.parseDouble(request.getParameter("lnt")));
        %>

        <table>
            <tr>
                <td>거리(Km)</td>
                <td><%= wifiDto.getDistance() %>
                </td>
            </tr>
            <tr>
                <td>관리번호</td>
                <td><%= wifiDto.getNo() %>
                </td>
            </tr>
            <tr>
                <td>자치구</td>
                <td><%= wifiDto.getGu()%>
                </td>
            </tr>
            <tr>
                <td>와이파이명</td>
                <td><a href="/wifi_war_exploded"><%= wifiDto.getName()%>
                </a></td>
            </tr>
            <tr>
                <td>도로명주소</td>
                <td><%= wifiDto.getAddress()%>
                </td>
            </tr>
            <tr>
                <td>상세주소</td>
                <td><%= wifiDto.getDetailAddress() %>
                </td>
            </tr>
            <tr>
                <td>설치위치(층)</td>
                <td><%= wifiDto.getFloors() %>
                </td>
            </tr>
            <tr>
                <td>설치유형</td>
                <td><%= wifiDto.getInstallType() %>
                </td>
            </tr>
            <tr>
                <td>설치기관</td>
                <td><%= wifiDto.getOrganization() %>
                </td>
            </tr>
            <tr>
                <td>서비스구분</td>
                <td><%= wifiDto.getService() %>
                </td>
            </tr>
            <tr>
                <td>망종류</td>
                <td><%= wifiDto.getWifiType() %>
                </td>
            </tr>
            <tr>
                <td>설치년도</td>
                <td><%= wifiDto.getInstalledYear() %>
                </td>
            </tr>
            <tr>
                <td>실내외구분</td>
                <td><%= wifiDto.getInOut() %>
                </td>
            </tr>
            <tr>
                <td>WIFI접속환경</td>
                <td><%= wifiDto.getEnviron() %>
                </td>
            </tr>
            <tr>
                <td>X좌표</td>
                <td><%= wifiDto.getY() %>
                </td>
            </tr>
            <tr>
                <td>Y좌표</td>
                <td><%= wifiDto.getX() %>
                </td>
            </tr>
            <tr>
                <td>작업일자</td>
                <td><%= wifiDto.getInstallDate() %>
                </td>
            </tr>
        </table>
    </div>

    <script>
        function addToBookmark() {
            var selectBox = document.getElementById('bookmark');
            var id = selectBox.options[selectBox.selectedIndex].value;
            var name = selectBox.options[selectBox.selectedIndex].getAttribute('name');

            window.location.href = "http://localhost:8080/wifi_war_exploded/add-to-bookmark.jsp" +
                "?bookmark-id="+ id + "&bookmark-name=" + name + "&wifi-name=<%=wifiDto.getName()%>";
        }
    </script>
</body>
</html>
