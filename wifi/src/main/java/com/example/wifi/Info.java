package com.example.wifi;

import java.io.*;
import java.sql.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "info", value = "/info")
public class Info extends HttpServlet {
    private String message;

    public void init() {
        message = "WIFI 정보를 정상적으로 저장하였습니다. ";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<br>");
        out.println("<h1 style=\"text-align: center;\">" + message + "</h1>");
        out.println("<div style=\"text-align: center;\"><a href=\"/wifi_war_exploded\">홈으로 가기</a></div>");

        String url = "jdbc:mariadb://52.79.72.162:3306/wifi";
        String dbUserId = "wifiuser";
        String dbPassword = "zerobase";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        try {
            // 커넥션 객체 생성
            connection = DriverManager.getConnection(url, dbUserId, dbPassword);

            // preparedStatement 객체 생성
            String sql = "select * from HISTORY;";

            preparedStatement = connection.prepareStatement(sql);

            // 쿼리 실행
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String no = rs.getString("MGR_NO");
                double distance = rs.getDouble("DISTANCE");

                out.println("<h1>" + no + "</h1>");
                out.println("<h1>" + distance + "</h1>");
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

        out.println("</body></html>");
    }

    public void destroy() {
    }
}