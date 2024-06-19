//package com.workwave.controller.traffic;
//
//
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStreamReader;
//import java.net.*;
//import java.nio.charset.StandardCharsets;
//
//@Controller
//@Slf4j
//public class TrafficController {
//
//    @GetMapping("/traffic-map")
//    public String trafficApi() throws IOException {
//
//        // ODsay Api Key 정보
//        String apiKey = "w1WM1Vpn8KiSqjB1BVcizSYtug8JqQ7bpTwvXxCSig0";
//
//        String urlInfo = "https://api.odsay.com/v1/api/searchBusLane?busNo=130&CID=1000&apiKey="
//                + URLEncoder.encode(apiKey, StandardCharsets.UTF_8);
//
//        // http 연결
//        URL url = new URL(urlInfo);
//        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//        conn.setRequestMethod("GET");
//        conn.setRequestProperty("Content-type", "application/json");
//
//        BufferedReader bufferedReader =
//                new BufferedReader(new InputStreamReader(conn.getInputStream()));
//
//        StringBuilder sb = new StringBuilder();
//        String line;
//        while ((line = bufferedReader.readLine()) != null) {
//            sb.append(line);
//        }
//        bufferedReader.close();
//        conn.disconnect();
//
//        // 결과 출력
//        // System.out.println(sb.toString());
//        return "traffic/Traffic";
//    }
//
//}
//
//
