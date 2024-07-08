package com.workwave.controller.traffic;

import com.workwave.dto.traffic.response.StationViewResponseDto;
import com.workwave.service.traffic.TrafficViewService;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
@CrossOrigin
public class TrafficViewController {

    private final TrafficViewService trafficViewService;

    @GetMapping("/traffic-rank")
    public String rankedView(Model model, HttpSession session){

        List<StationViewResponseDto> favoriteView = trafficViewService.view(session);
        model.addAttribute("favoriteView", favoriteView);

        return "traffic/FavoriteTraffic";
    }
}
