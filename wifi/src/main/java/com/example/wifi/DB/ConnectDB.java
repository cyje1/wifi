package com.example.wifi.DB;

import com.example.wifi.Dto.BookmarkDto;
import com.example.wifi.Dto.BookmarkListDto;
import com.example.wifi.Dto.HistoryDto;
import com.example.wifi.Dto.WifiDto;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ConnectDB {
    private String URL = "jdbc:mariadb://52.79.72.162:3306/wifi";
    private String USER_ID = "wifiuser";
    private String PASSWORD = "zerobase";

    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet rs = null;

    public void saveWifi(JsonArray jsonArray) {
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

                preparedStatement.executeUpdate();
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

    public WifiDto selectWifiWithNo(String no, double lat, double lnt) {
        WifiDto wifiDto = new WifiDto();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "select *, round(ST_DISTANCE(" +
                    " point( Y , X ), " +
                    " point(" + lat + ", " + lnt + ") " +
                    ") * 100, 4) as DISTANCE " +
                    "from WIFI_INFO WHERE MGR_NO = ? ;";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, no);
            rs = preparedStatement.executeQuery();

            rs.next();
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

        return wifiDto;
    }

    public List<WifiDto> selectWifiWithLocation(double lat, double lnt) {
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
            String sql = "select *, round(ST_DISTANCE(" +
                    " point( Y , X ), " +
                    " point(" + lat + ", " + lnt + ") " +
                    ") * 100, 4) as DISTANCE " +
                    "from WIFI_INFO " +
                    "order by DISTANCE " +
                    "limit 20;";

            preparedStatement = connection.prepareStatement(sql);
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

            // 히스토리 저장
            sql = "insert into HISTORY (X, Y, SAVED_DATE) values ( ? , ? , now());";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, String.valueOf(lat));
            preparedStatement.setString(2, String.valueOf(lnt));

            preparedStatement.executeUpdate();

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

    public List<HistoryDto> selectHistory() {
        List<HistoryDto> list = new ArrayList<>();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "select * from HISTORY; ";
            preparedStatement = connection.prepareStatement(sql);
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                HistoryDto historyDto = new HistoryDto();

                historyDto.setId(rs.getInt("ID"));
                historyDto.setX(rs.getString("X"));
                historyDto.setY(rs.getString("Y"));
                historyDto.setDate(rs.getTimestamp("SAVED_DATE").toLocalDateTime());

                list.add(historyDto);
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

    public void deleteHistory(int id) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "delete from HISTORY where id = ? ; ";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            preparedStatement.executeQuery();

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

    }

    public void saveBookmark(String name, int order) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "insert into BOOKMARK (NAME, NUMBER, REGISTERED_DATE) values ( ? , ? , now()); ";
            preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1, name);
            preparedStatement.setInt(2, order);

            preparedStatement.executeUpdate();

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

    public List<BookmarkDto> selectBookmark() {
        List<BookmarkDto> list = new ArrayList<>();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "select * from BOOKMARK ORDER BY NUMBER; ";
            preparedStatement = connection.prepareStatement(sql);
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                BookmarkDto bookmarkDto = new BookmarkDto();

                bookmarkDto.setId(rs.getInt("ID"));
                bookmarkDto.setName(rs.getString("NAME"));
                bookmarkDto.setOrder(rs.getInt("NUMBER"));
                bookmarkDto.setRegisteredDate(rs.getTimestamp("REGISTERED_DATE").toLocalDateTime());
                if (rs.getTimestamp("UPDATED_DATE") != null) {
                    bookmarkDto.setUpdatedDate(rs.getTimestamp("UPDATED_DATE").toLocalDateTime());
                }
                list.add(bookmarkDto);
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

    public void updateBookmark(String name, int order, int id) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "update BOOKMARK set NAME = ? , NUMBER = ?, UPDATED_DATE = now() where ID = ? ; ";
            preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1, name);
            preparedStatement.setInt(2, order);
            preparedStatement.setInt(3, id);

            preparedStatement.executeUpdate();

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

    public void deleteBookmark(int id) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "delete from BOOKMARK where id = ? ; ";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            preparedStatement.executeQuery();

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
    }

    public List<BookmarkListDto> selectBookmarkList() {
        List<BookmarkListDto> list = new ArrayList<>();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "select * from BOOKMARK_LIST; ";
            preparedStatement = connection.prepareStatement(sql);
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                BookmarkListDto bookmarkListDto = new BookmarkListDto();

                bookmarkListDto.setId(rs.getInt("ID"));
                bookmarkListDto.setBookmarkName(rs.getString("BOOKMARK_NAME"));
                bookmarkListDto.setWifiName(rs.getString("WIFI_NAME"));
                bookmarkListDto.setRegisteredDate(rs.getTimestamp("REGISTERED_DATE").toLocalDateTime());

                list.add(bookmarkListDto);
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

    public BookmarkListDto selectBookmarkListWithId(int id, String wifiName) {
        BookmarkListDto bookmarkListDto = new BookmarkListDto();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "select * from BOOKMARK_LIST where id = ? and WIFI_NAME = ?; ";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, wifiName);
            rs = preparedStatement.executeQuery();

            rs.next();
            bookmarkListDto.setId(rs.getInt("ID"));
            bookmarkListDto.setBookmarkName(rs.getString("BOOKMARK_NAME"));
            bookmarkListDto.setWifiName(rs.getString("WIFI_NAME"));
            bookmarkListDto.setRegisteredDate(rs.getTimestamp("REGISTERED_DATE").toLocalDateTime());


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

        return bookmarkListDto;
    }

    public void deleteBookmarkList(int id, String wifiName) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "delete from BOOKMARK_LIST where id = ? and WIFI_NAME = ?; ";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, wifiName);
            preparedStatement.executeQuery();

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
    }

    public void addToBookmark(int bookmarkId, String bookmarkName, String wifiName) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);

            String sql = "insert into BOOKMARK_LIST (ID, BOOKMARK_NAME, WIFI_NAME, REGISTERED_DATE) " +
                    "values ( ? , ? , ? , now()); ";
            preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setInt(1, bookmarkId);
            preparedStatement.setString(2, bookmarkName);
            preparedStatement.setString(3, wifiName);

            preparedStatement.executeUpdate();

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
