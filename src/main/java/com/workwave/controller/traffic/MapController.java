package com.workwave.controller.traffic;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@Controller
@Slf4j
public class MapController {


    @GetMapping("/find-map")
    public String trafficMap() throws IOException {

        // ODsay Api Key 정보
        String apiKey = "avqjby448YJDDqi4buwo5S69Uz5sf0nc3aEMdXWFzsQ";

        String urlInfo = "https://api.odsay.com/v1/api/loadLane?mapObject=0:0@12018:1:-1:-1&apiKey="
                + URLEncoder.encode(apiKey, "UTF-8");

        // http 연결
        URL url = new URL(urlInfo);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");

        BufferedReader bufferedReader =
                new BufferedReader(new InputStreamReader(conn.getInputStream()));

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = bufferedReader.readLine()) != null) {
            sb.append(line);
        }
        bufferedReader.close();
        conn.disconnect();

        // 결과 출력
        // System.out.println(sb.toString());
        return "traffic";
    }
}
