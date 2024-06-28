package com.workwave.controller.traffic;

import com.workwave.common.traffic.myInfoPage;
import com.workwave.common.traffic.myPageMaker;
import com.workwave.dto.traffic.request.totalTrafficInfoDto;
import com.workwave.dto.traffic.response.trafficInfoDto;
import com.workwave.dto.user.JoinDto;
import com.workwave.dto.user.LoginDto;
import com.workwave.dto.user.LoginUserInfoDto;
import com.workwave.entity.User;
import com.workwave.service.traffic.trafficService;
import com.workwave.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class TrafficController {

    private final trafficService trafficService;


    @PostMapping("/traffic-Info")
    public String trafficInformation(@RequestBody trafficInfoDto trafficInfo, HttpSession session){

        System.out.println("isLoggedIn: " + LoginUtil.isLoggedIn(session));
        System.out.println("getLoggedIN: " + LoginUtil.getLoggedInUser(session));
        String userId = LoginUtil.getLoggedInUser(session).getUserId();

        trafficInfo.setUserId(userId);
        System.out.println("trafficInfo = " + trafficInfo);
        trafficService.save(trafficInfo);


        return "traffic/Traffic";
    }

    @GetMapping("/traffic-myInfo")
    public String findTrafficInfo(Model model, myInfoPage page){

        System.out.println(page);
        List<totalTrafficInfoDto> totalTraffic = trafficService.findAll(page);
        myPageMaker maker = new myPageMaker(page,trafficService.getCount());
        System.out.println(maker);
        model.addAttribute("maker",maker);
        model.addAttribute("totalTraffic",totalTraffic);

        return "traffic/myTrafficInfo";
    }


}