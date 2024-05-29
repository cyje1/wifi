<%@ page import="com.example.wifi.DB.ConnectDB" %>
<%@ page import="com.example.wifi.Dto.WifiDto" %>
<%@ page import="java.util.List" %><%--
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
    <a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기</a>

    <br/>
    <br/>

    <div>
        <%
            ConnectDB connectDB = new ConnectDB();
            WifiDto wifiDto = connectDB.selectWifiWithNo(request.getParameter("mgrNo"),
                    Double.parseDouble(request.getParameter("lat")),
                    Double.parseDouble(request.getParameter("lnt")));
        %>

        <table>
            <tr>
                <td>거리(Km)</td>
                <td><%= wifiDto.getDistance() %></td>
            </tr>
            <tr>
                <td>관리번호</td>
                <td><%= wifiDto.getNo() %></td>
            </tr>
            <tr>
                <td>자치구</td>
                <td><%= wifiDto.getGu()%></td>
            </tr>
            <tr>
                <td>와이파이명</td>
                <td><a href="/wifi_war_exploded"><%= wifiDto.getName()%></a></td>
            </tr>
            <tr>
                <td>도로명주소</td>
                <td><%= wifiDto.getAddress()%></td>
            </tr>
            <tr>
                <td>상세주소</td>
                <td><%= wifiDto.getDetailAddress() %></td>
            </tr>
            <tr>
                <td>설치위치(층)</td>
                <td><%= wifiDto.getFloors() %></td>
            </tr>
            <tr>
                <td>설치유형</td>
                <td><%= wifiDto.getInstallType() %></td>
            </tr>
            <tr>
                <td>설치기관</td>
                <td><%= wifiDto.getOrganization() %></td>
            </tr>
            <tr>
                <td>서비스구분</td>
                <td><%= wifiDto.getService() %></td>
            </tr>
            <tr>
                <td>망종류</td>
                <td><%= wifiDto.getWifiType() %></td>
            </tr>
            <tr>
                <td>설치년도</td>
                <td><%= wifiDto.getInstalledYear() %></td>
            </tr>
            <tr>
                <td>실내외구분</td>
                <td><%= wifiDto.getInOut() %></td>
            </tr>
            <tr>
                <td>WIFI접속환경</td>
                <td><%= wifiDto.getEnviron() %></td>
            </tr>
            <tr>
                <td>X좌표</td>
                <td><%= wifiDto.getY() %></td>
            </tr>
            <tr>
                <td>Y좌표</td>
                <td><%= wifiDto.getX() %></td>
            </tr>
            <tr>
                <td>작업일자</td>
                <td><%= wifiDto.getInstallDate() %></td>
            </tr>
        </table>
    </div>

</body>
</html>