package com.workwave.controller.traffic;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.logging.Logger;
import org.mybatis.logging.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@Slf4j
public class TrafficController {

    @PostMapping("/traffic-Info")
    public String trafficInformation(){

       log.info("요청됨");

        return "redirect:traffic-map";
    }

}
