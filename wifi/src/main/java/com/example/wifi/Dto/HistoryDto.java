package com.example.wifi.Dto;

import java.time.LocalDateTime;

public class HistoryDto {
    private int id;
    private String x;
    private String y;
    private LocalDateTime date;

    public void setId(int id) {
        this.id = id;
    }

    public void setX(String x) {
        this.x = x;
    }

    public void setY(String y) {
        this.y = y;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public String getX() {
        return x;
    }

    public String getY() {
        return y;
    }

    public LocalDateTime getDate() {
        return date;
    }
}
