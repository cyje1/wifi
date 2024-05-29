package com.example.wifi.Dto;

import java.time.LocalDateTime;

public class BookmarkDto {
    private int id;
    private String name;
    private int order;
    private LocalDateTime registeredDate;
    private LocalDateTime updatedDate;

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public void setRegisteredDate(LocalDateTime registeredDate) {
        this.registeredDate = registeredDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getOrder() {
        return order;
    }

    public LocalDateTime getRegisteredDate() {
        return registeredDate;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }
}
