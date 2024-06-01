<%@ page import="com.example.wifi.DB.ConnectDB" %>
<%@ page import="com.example.wifi.Dto.WifiDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
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
    <h1><%= "와이파이 정보 구하기" %></h1>

    <a href="/wifi_war_exploded">홈 |</a>
    <a href="/wifi_war_exploded/history.jsp">위치 히스토리 목록 |</a>
    <a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기 |</a>
    <a href="/wifi_war_exploded/bookmark-list.jsp">북마크 보기 |</a>
    <a href="/wifi_war_exploded/bookmark-group.jsp">북마크 그룹 관리</a>

    <br/>
    <br/>

    <label for="latitude"> Latitude : </label>
    <input type="text" id="latitude" name="latitude">
    <label for="longitude"> Longitude:</label>
    <input type="text" id="longitude" name="longitude">

    <button onclick="getLocation()"> 내 위치 가져오기 </button>
    <button onclick="sendLocation()"> 근처 WIFI 정보 보기 </button>

    <br/>
    <br/>

<script>
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition);
        } else {
            document.getElementById("message").innerHTML = "좌표를 확인할 수 없으니 직접 입력하시기 바랍니다.";
        }
    }

    function showPosition(position) {
        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;
        document.getElementById("latitude").value = latitude;
        document.getElementById("longitude").value = longitude;
    }

    function sendLocation() {
        var latitude = document.getElementById("latitude").value;
        var longitude = document.getElementById("longitude").value;

        if (latitude != "0.0" && longitude != "0.0") {
            var url = "http://localhost:8080/wifi_war_exploded/?latitude="
                + latitude + "&longitude=" + longitude;
            window.location.href = url;
        } else {
            alert("좌표를 입력해주시기 바랍니다.");
        }
    }

    function initializeFields() {
        var latitude = getUrlParameter('latitude') || 0.0;
        var longitude = getUrlParameter('longitude') || 0.0;

        if (latitude == 0 || longitude == 0) {
            document.getElementById('latitude').value = "0.0";
            document.getElementById('longitude').value = "0.0";
        } else {
            document.getElementById('latitude').value = latitude;
            document.getElementById('longitude').value = longitude;
        }
    }

    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    window.onload = initializeFields;
</script>
    <div>
        <table>
            <thead>
                <tr>
                    <th>거리(Km)</th>
                    <th>관리번호</th>
                    <th>자치구</th>
                    <th>와이파이명</th>
                    <th>도로명주소</th>
                    <th>상세주소</th>
                    <th>설치위치(층)</th>
                    <th>설치유형</th>
                    <th>설치기관</th>
                    <th>서비스구분</th>
                    <th>망종류</th>
                    <th>설치년도</th>
                    <th>실내외구분</th>
                    <th>WIFI 접속환경</th>
                    <th>X좌표</th>
                    <th>Y좌표</th>
                    <th>작업일자</th>
                </tr>
            </thead>
            <tbody>
                    <%
                        Double latitude = request.getParameter("latitude") == null ?
                                0 : Double.parseDouble(request.getParameter("latitude"));
                        Double longitude = request.getParameter("longitude") == null ?
                                0 : Double.parseDouble(request.getParameter("longitude"));


                        if (latitude != 0 && longitude != 0) {
                            ConnectDB connectDB = new ConnectDB();
                            List<WifiDto> list = connectDB.selectWifiWithLocation(latitude, longitude);

                            for (int i = 0; i < list.size(); i++) {
                    %>
                <tr>
                    <td> <%= list.get(i).getDistance() %> </td>
                    <td> <%= list.get(i).getNo() %> </td>
                    <td> <%= list.get(i).getGu() %> </td>
                    <td> <a href="/wifi_war_exploded/detail.jsp?mgrNo=<%=list.get(i).getNo()%>&lat=<%=latitude%>&lnt=<%=longitude%>">
                        <%= list.get(i).getName() %> </a> </td>
                    <td> <%= list.get(i).getAddress() %> </td>
                    <td> <%= list.get(i).getDetailAddress() %> </td>
                    <td> <%= list.get(i).getFloors() %> </td>
                    <td> <%= list.get(i).getInstallType() %> </td>
                    <td> <%= list.get(i).getOrganization() %> </td>
                    <td> <%= list.get(i).getService() %> </td>
                    <td> <%= list.get(i).getWifiType() %> </td>
                    <td> <%= list.get(i).getInstalledYear() %> </td>
                    <td> <%= list.get(i).getInOut() %> </td>
                    <td> <%= list.get(i).getEnviron() %> </td>
                    <td> <%= list.get(i).getY() %> </td>
                    <td> <%= list.get(i).getX() %> </td>
                    <td> <%= list.get(i).getInstallDate() %> </td>
                </tr>
                    <% }
                        } else { %>
                    <td colspan="20">
                        <br/>
                        위치 정보를 입력한 후에 조회해 주세요.
                        <br/>
                        <br/>
                    </td>
                    <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>