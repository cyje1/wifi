<%@ page import="com.example.wifi.SaveInfo" %>
<%@ page import="com.example.wifi.WifiDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <style>
        table{
            width: 100%;
        }
        th, td {
            border:solid 1px #000;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1><%= "와이파이 정보 구하기" %>
    </h1>

    <a href="/wifi_war_exploded">홈 |</a>
    <a href="history">위치 히스토리 목록 |</a>
    <a href="/wifi_war_exploded/load-wifi.jsp">Open API 와이파이 정보 가져오기</a>

    <br/>
    <br/>

    <label for="lat"> Latitude : </label>
    <input type="text" id="lat" name="lat">
    <label for="lnt">Latitude:</label> LNT :
    <input type="text" id="lnt" name="lnt">
    <button onclick="getLocation()"> 내 위치 가져오기</button>
    <button onclick="sendLocation()"> 내 위치 가져오기</button>

    <p id="message"></p>

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
        document.getElementById("lat").value = latitude;
        document.getElementById("lnt").value = longitude;
    }

    function sendLocation() {
        var lat = document.getElementById("lat").value;
        var lnt = document.getElementById("lnt").value;
        if (lat && lnt) {
            var url = `http://localhost:8080/submit?latitude=${lat}&longitude=${lnt}`;
            window.location.href = url;
        } else {
            document.getElementById("message").innerHTML = "좌표를 입력해주시기 바랍니다.";
        }
    }
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
                    <%  SaveInfo saveInfo = new SaveInfo();
                        List<WifiDto> list = saveInfo.dbSelect();

                        if (list.size() > 0) {
                            for (int i = 0; i < list.size(); i++) {
                    %>
                <tr>
                    <td> 거리 구해서 넣기 </td>
                    <td> <%= list.get(i).getNo() %> </td>
                    <td> <%= list.get(i).getGu() %>  </td>
                    <td> <%= list.get(i).getName() %>  </td>
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
<%--<script>--%>
<%--    let list = [--%>
<%--        {name: "망원한강공원1", addr: "마포구", latitude: 37.552788, longitude: 126.89939},--%>
<%--        {name: "망원한강공원2", addr: "마포구", latitude: 37.552345, longitude: 126.89989},--%>
<%--    ]--%>

<%--    function getDistance(lat1, lon1, lat2, lon2) {--%>
<%--        var radlat1 = Math.PI * lat1 / 180;--%>
<%--        var radlat2 = Math.PI * lat2 / 180;--%>
<%--        var theta = lon1 - lon2;--%>
<%--        var radtheta = Math.PI * theta / 180;--%>
<%--        var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);--%>

<%--        dist = Math.acos(dist);--%>
<%--        dist = dist * 180 / Math.PI;--%>
<%--        dist = dist * 60 * 1.1515;--%>
<%--        dist = dist * 1.609344--%>

<%--        return dist;--%>
<%--    }--%>

<%--    navigator.geolocation.getCurrentPosition((position) => {--%>
<%--        let latitude = position.coords.latitude;--%>
<%--        let longitude = position.coords.longitude;--%>

<%--        console.log('latitude', latitude);--%>
<%--        console.log('longitude', longitude);--%>

<%--        for (let i = 0; i < list.length; i++) {--%>
<%--            let distance = getDistance(latitude, longitude, list[i].latitude, list[i].longitude);--%>
<%--            list[i].distance = distance;--%>
<%--        }--%>

<%--        let newList = list.sort(function (a, b) {--%>
<%--            if (a.distance > b.distance) {--%>
<%--                return 1;--%>
<%--            }--%>

<%--            if (a.distance < b.distance) {--%>
<%--                return -1;--%>
<%--            }--%>
<%--        });--%>

<%--        console.log(newList);--%>
<%--    }, (err) => {--%>

<%--    });--%>
<%--</script>--%>
</body>
</html>