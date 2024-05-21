package com.example.wifi;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "info", value = "/info")
public class info extends HttpServlet {
    private String message;

    public void init() {
        message = "와이파이 정보 가져오기";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("<a href=\"/wifi_war_exploded\">홈 |</a>");
        out.println("<a href=\"history\">위치 히스토리 목록 |</a>");
        out.println("<a href=\"info\">Open API 와이파이 정보 가져오기</a>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}