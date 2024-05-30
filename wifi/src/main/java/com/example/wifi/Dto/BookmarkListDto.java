package com.example.wifi.Dto;

import java.time.LocalDateTime;

public class BookmarkListDto {
    private int id;
    private String bookmarkName;
    private String wifiName;
    private LocalDateTime registeredDate;

    public void setId(int id) {
        this.id = id;
    }

    public void setBookmarkName(String bookmarkName) {
        this.bookmarkName = bookmarkName;
    }

    public void setWifiName(String wifiName) {
        this.wifiName = wifiName;
    }

    public void setRegisteredDate(LocalDateTime registeredDate) {
        this.registeredDate = registeredDate;
    }

    public int getId() {
        return id;
    }

    public String getBookmarkName() {
        return bookmarkName;
    }

    public String getWifiName() {
        return wifiName;
    }

    public LocalDateTime getRegisteredDate() {
        return registeredDate;
    }
}
