package com.workwave.controller.traffic;

import com.workwave.dto.traffic.response.trafficInfo;
import com.workwave.service.traffic.trafficService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
@Slf4j
@RequiredArgsConstructor
public class TrafficController {

    private final trafficService trafficService;

    @PostMapping("/traffic-Info")
    public String trafficInformation(@RequestBody trafficInfo trafficinfo){

        // 서비스에게 저장 요청 위임
        trafficService.save(trafficinfo);

        return "redirect:traffic-map";
    }

}