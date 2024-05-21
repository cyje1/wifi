<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "와이파이 정보 구하기" %>
</h1>

<a href="/wifi_war_exploded">홈 |</a>
<a href="history">위치 히스토리 목록 |</a>
<a href="info">Open API 와이파이 정보 가져오기</a>

<br/>
<br/>

<p>LAT :  <input id="lat"></input> , LNT : <input id="lnt"></input> <button onclick="btnClick()"> 내 위치 가져오기</button> </p>
<input type="submit" value="근처 WIPI 정보 보기">

<script>
    function btnClick() {
        const lat = document.getElementById("lat");
        const lnt = document.getElementById("lnt");

        lat.value = "lat";
        lnt.value = "lnt";
    }

</script>

<script>
    let list = [
        {name: "망원한강공원1", addr: "마포구", latitude: 37.552788, longitude: 126.89939},
        {name: "망원한강공원2", addr: "마포구", latitude: 37.552345, longitude: 126.89989},
    ]

    function getDistance(lat1, lon1, lat2, lon2) {
        var radlat1 = Math.PI * lat1 / 180;
        var radlat2 = Math.PI * lat2 / 180;
        var theta = lon1 - lon2;
        var radtheta = Math.PI * theta / 180;
        var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);

        dist = Math.acos(dist);
        dist = dist * 180 / Math.PI;
        dist = dist * 60 * 1.1515;
        dist = dist * 1.609344

        return dist;
    }

    navigator.geolocation.getCurrentPosition((position) => {
        let latitude = position.coords.latitude;
        let longitude = position.coords.longitude;

        console.log('latitude', latitude);
        console.log('longitude', longitude);

        for (let i = 0; i < list.length; i++) {
            let distance = getDistance(latitude, longitude, list[i].latitude, list[i].longitude);
            list[i].distance = distance;
        }

        let newList = list.sort(function (a, b) {
            if (a.distance > b.distance) {
                return 1;
            }

            if (a.distance < b.distance) {
                return -1;
            }
        });

        console.log(newList);
    }, (err) => {

    });
</script>
</body>
</html>