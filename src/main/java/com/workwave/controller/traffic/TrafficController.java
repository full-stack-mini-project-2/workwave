package com.workwave.controller.traffic;

import com.workwave.common.traffic.myInfoPage;
import com.workwave.common.traffic.myPageMaker;
import com.workwave.dto.traffic.request.totalTrafficInfoDto;
import com.workwave.dto.traffic.response.trafficInfoDto;
import com.workwave.service.traffic.trafficService;
import com.workwave.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class TrafficController {

    private final trafficService trafficService;


    @PostMapping("/traffic-Info")
    public String trafficInformation(@RequestBody trafficInfoDto trafficInfo, HttpSession session){

        String userId = LoginUtil.getLoggedInUser(session).getUserId();

        try {
            trafficInfo.setUserId(userId);
            trafficService.save(trafficInfo,session);
        } catch (Exception e) {
            return "error/404";

        }


        return "traffic/Traffic";
    }

    @GetMapping("/traffic-myInfo")
    public String findTrafficInfo(Model model, myInfoPage page, HttpSession session, @RequestParam(value = "sort", required = false) String sort) {

        List<totalTrafficInfoDto> totalTraffic = null;
        try {
            totalTraffic = trafficService.findAll(page, session, sort);
        } catch (Exception e) {
            boolean loggedIn = LoginUtil.isLoggedIn(session);

            if(!loggedIn){
                return "redirect:/login";
            };
        }

        myPageMaker maker = new myPageMaker(page, trafficService.getCount(session));

        String userId = LoginUtil.getLoggedInUser(session).getUserId();
        maker.setUserId(userId);

        model.addAttribute("maker", maker);
        model.addAttribute("totalTraffic", totalTraffic);

        return "traffic/myTrafficInfo";
    }














}