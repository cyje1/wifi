<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<html>
<head>
    <title>와이파이 정보 구하기</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<%
    String lat = request.getParameter("lat") == null ? "0.0" : request.getParameter("lat");
    String lnt = request.getParameter("lnt") == null ? "0.0" : request.getParameter("lnt");
%>

<div class="input">
    <span>LAT:</span>
    <input type="text" id="lat" value="<%=lat%>">

    <span>LNT:</span>
    <input type="text" id="lnt" value="<%=lnt%>">

    <button id="btn_cur_position"><span>내 위치 가져오기</span></button>
    <button id="btn_nearest_wifi"><span>근처 Wifi 정보 보기</span></button>
</div>


<div>

</div>

<script>
    let getCurPosition = document.getElementById("btn_cur_position");
    let getNearestWifi = document.getElementById("btn_nearest_wifi");

    let lat = null;
    let lnt = null;

    window.onload = () => {
        lat = document.getElementById("lat").value;
        lnt = document.getElementById("lnt").value;
    }

    getCurPosition.addEventListener("click", function () {
        if ('geolocation' in navigator) {
            navigator.geolocation.getCurrentPosition(function (position){
                let latitude = position.coords.latitude;
                let longitude = position.coords.longitude;
                document.getElementById("lat").value = latitude;
                document.getElementById("lnt").value = longitude;
            })
        } else{
            alert("위치 정보를 확인할 수 없으니 직접 입력해주시기 바랍니다.")
        }
    });

    getNearestWifi.addEventListener("click", function (){
        let latitude = document.getElementById("lat").value;
        let longitude = document.getElementById("lnt").value;

        if (latitude !== "" || longitude !== "") {
            window.location.assign("http://localhost:8080?lat=" + latitude + "&lnt=" + longitude);
        } else {
            alert("위치 정보를 입력하신 후에 조회해주세요.")
        }
    })
</script>

</body>
</html>
