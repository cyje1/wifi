<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.wifi.DB.getWifiInfo" %>
<html>
<head>
    <title>와이파이 정보 가져오기</title>
</head>
<body>

    <%
        int count = getWifiInfo.getTotalCount();
        getWifiInfo.getWifiData();
    %>

    <h1 style="text-align: center;"> <%=count%> WIFI 정보를 정상적으로 저장하였습니다. </h1>
    <div style="text-align: center;"><a href="/wifi_war_exploded">홈으로 가기</a></div>

</body>
</html>