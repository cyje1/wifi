package com.example.wifi.DB;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;

public class getWifiInfo {
    private static String URL = "http://openapi.seoul.go.kr:8088/594e497a7a636b6437357441645668/json/TbPublicWifiInfo/";

    public static int getTotalCount() throws IOException {
        int cnt = 0;

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(URL + "1/1").build();

        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful()) {
                String responseData = response.body().string();
                JsonElement jsonElement = JsonParser.parseString(responseData);

                cnt = jsonElement.getAsJsonObject()
                        .get("TbPublicWifiInfo")
                        .getAsJsonObject().get("list_total_count")
                        .getAsInt();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return cnt;
    }

    public static void getWifiData() throws IOException {
//        int count = getTotalCount();
        int count = 10;
        int start = 1;
        int end = 10;

        OkHttpClient client = new OkHttpClient();

        try {
            while (true) {
                Request request = new Request.Builder().url(URL + start + "/" + end).build();
                Response response = client.newCall(request).execute();

                if (response.isSuccessful()) {
                    String responseData = response.body().string();
                    JsonElement jsonElement = JsonParser.parseString(responseData);

                    JsonArray jsonArray = jsonElement.getAsJsonObject().get("TbPublicWifiInfo")
                            .getAsJsonObject().get("row")
                            .getAsJsonArray();

                    ConnectDB saveInfo = new ConnectDB();
                    saveInfo.dbInsert(jsonArray);
                }

                if (end == count) {
                    break;
                }

                start += 1000;
                end = Math.min(end + 1000, count);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
