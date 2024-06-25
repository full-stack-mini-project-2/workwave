package com.workwave.controller.traffic;

import com.workwave.dto.traffic.request.totalTrafficInfoDto;
import com.workwave.dto.traffic.response.trafficInfo;
import com.workwave.service.traffic.trafficService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class TrafficController {

    private final trafficService trafficService;

    @PostMapping("/traffic-Info")
    public String trafficInformation(@RequestBody trafficInfo trafficinfo){

        trafficService.save(trafficinfo);


        return "traffic/Traffic";
    }

    @GetMapping("/traffic-myInfo")
    public String findTrafficInfo(Model model){

        List<totalTrafficInfoDto> totalTraffic = trafficService.findAll();
        model.addAttribute("totalTraffic",totalTraffic);

        return "traffic/myTrafficInfo";
    }


}