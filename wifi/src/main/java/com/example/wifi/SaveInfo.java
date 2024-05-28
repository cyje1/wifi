package com.example.wifi;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SaveInfo {
    private String URL = "jdbc:mariadb://52.79.72.162:3306/wifi";
    private String USER_ID = "wifiuser";
    private String PASSWORD = "zerobase";

    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet rs = null;

    public List<WifiDto> dbSelect() {
        List<WifiDto> list = new ArrayList<>();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            // 커넥션 객체 생성
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            // preparedStatement 객체 생성
            String sql = "select MGR_NO, GU, NAME, ADDRESS, DETAIL_ADDRESS, FLOORS , INSTALL_TYPE, " +
                    "ORGANIZATION, SERVICE, WIFI_TYPE, INSTALLED_YEAR, IN_OUT, ENVIRON , Y , X , INSTALL_DATE " +
                    "from WIFI_INFO; ";

            preparedStatement = connection.prepareStatement(sql);

            // 쿼리 실행
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                WifiDto wifiDto = new WifiDto();

                wifiDto.setNo(rs.getString("MGR_NO"));
                wifiDto.setGu(rs.getString("GU"));
                wifiDto.setName(rs.getString("NAME"));
                wifiDto.setAddress(rs.getString("ADDRESS"));
                wifiDto.setDetailAddress(rs.getString("DETAIL_ADDRESS"));

                wifiDto.setFloors(rs.getString("FLOORS"));
                wifiDto.setInstallType(rs.getString("INSTALL_TYPE"));
                wifiDto.setOrganization(rs.getString("ORGANIZATION"));
                wifiDto.setService(rs.getString("SERVICE"));
                wifiDto.setWifiType(rs.getString("WIFI_TYPE"));

                wifiDto.setInstalledYear(rs.getString("INSTALLED_YEAR"));
                wifiDto.setInOut(rs.getString("IN_OUT"));
                wifiDto.setEnviron(rs.getString("ENVIRON"));
                wifiDto.setY(rs.getString("Y"));
                wifiDto.setX(rs.getString("X"));

                wifiDto.setInstallDate(rs.getString("INSTALL_DATE"));

                list.add(wifiDto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            try {
                if (rs != null && !rs.isClosed()) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                if (preparedStatement != null && !preparedStatement.isClosed()) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                if (connection != null && !connection.isClosed()) {
                    connection.isClosed();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return list;
    }

    public List<WifiDto> dbSelectWithLocation(double lat, double lnt) {
        List<WifiDto> list = new ArrayList<>();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            // 커넥션 객체 생성
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            // preparedStatement 객체 생성
            String sql
                    = "select *, " +
                    "(6371 * acos( cos( radians( ? ) ) * cos( radians(" + lat +" ) ) * cos( radians(" + lnt + ") - radians( ? ) ) + " +
                    "sin( radians( ? ) ) * sin( radians(" + lat + ") ) ) ) AS DISTANCE " +
                    "from WIFI_INFO " +
                    "order by DISTANCE " +
                    "limit 20;";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setDouble(1, lat);
            preparedStatement.setDouble(2, lnt);
            preparedStatement.setDouble(3, lat);

            // 쿼리 실행
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                WifiDto wifiDto = new WifiDto();

                wifiDto.setDistance(rs.getDouble("DISTANCE"));

                wifiDto.setNo(rs.getString("MGR_NO"));
                wifiDto.setGu(rs.getString("GU"));
                wifiDto.setName(rs.getString("NAME"));
                wifiDto.setAddress(rs.getString("ADDRESS"));
                wifiDto.setDetailAddress(rs.getString("DETAIL_ADDRESS"));

                wifiDto.setFloors(rs.getString("FLOORS"));
                wifiDto.setInstallType(rs.getString("INSTALL_TYPE"));
                wifiDto.setOrganization(rs.getString("ORGANIZATION"));
                wifiDto.setService(rs.getString("SERVICE"));
                wifiDto.setWifiType(rs.getString("WIFI_TYPE"));

                wifiDto.setInstalledYear(rs.getString("INSTALLED_YEAR"));
                wifiDto.setInOut(rs.getString("IN_OUT"));
                wifiDto.setEnviron(rs.getString("ENVIRON"));
                wifiDto.setY(rs.getString("Y"));
                wifiDto.setX(rs.getString("X"));

                wifiDto.setInstallDate(rs.getString("INSTALL_DATE"));

                list.add(wifiDto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            try {
                if (rs != null && !rs.isClosed()) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                if (preparedStatement != null && !preparedStatement.isClosed()) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                if (connection != null && !connection.isClosed()) {
                    connection.isClosed();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return list;
    }

    public void dbInsert(JsonArray jsonArray) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            for (int i = 0; i < jsonArray.size(); i++) {
                JsonObject jsonObject = jsonArray.get(i).getAsJsonObject();

                String sql = "insert into WIFI_INFO " +
                        "(MGR_NO, GU, NAME, ADDRESS, DETAIL_ADDRESS, FLOORS , INSTALL_TYPE, " +
                        "ORGANIZATION, SERVICE, WIFI_TYPE, INSTALLED_YEAR, IN_OUT, ENVIRON , Y , X , INSTALL_DATE) " +
                        "values ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? );";

                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, jsonObject.get("X_SWIFI_MGR_NO").getAsString());
                preparedStatement.setString(2, jsonObject.get("X_SWIFI_WRDOFC").getAsString());
                preparedStatement.setString(3, jsonObject.get("X_SWIFI_MAIN_NM").getAsString());
                preparedStatement.setString(4, jsonObject.get("X_SWIFI_ADRES1").getAsString());
                preparedStatement.setString(5, jsonObject.get("X_SWIFI_ADRES2").getAsString());
                preparedStatement.setString(6, jsonObject.get("X_SWIFI_INSTL_FLOOR").getAsString());
                preparedStatement.setString(7, jsonObject.get("X_SWIFI_INSTL_TY").getAsString());
                preparedStatement.setString(8, jsonObject.get("X_SWIFI_INSTL_MBY").getAsString());
                preparedStatement.setString(9, jsonObject.get("X_SWIFI_SVC_SE").getAsString());
                preparedStatement.setString(10, jsonObject.get("X_SWIFI_CMCWR").getAsString());
                preparedStatement.setString(11, jsonObject.get("X_SWIFI_CNSTC_YEAR").getAsString());
                preparedStatement.setString(12, jsonObject.get("X_SWIFI_INOUT_DOOR").getAsString());
                preparedStatement.setString(13, jsonObject.get("X_SWIFI_REMARS3").getAsString());
                preparedStatement.setString(14, jsonObject.get("LAT").getAsString());
                preparedStatement.setString(15, jsonObject.get("LNT").getAsString());
                preparedStatement.setString(16, jsonObject.get("WORK_DTTM").getAsString());

                // 쿼리 실행
                int affectedRows = preparedStatement.executeUpdate();

                if (affectedRows > 0) {
                    System.out.println("success");
                } else {
                    System.out.println("fail");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            try {
                if (preparedStatement != null && !preparedStatement.isClosed()) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                if (connection != null && !connection.isClosed()) {
                    connection.isClosed();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


}
