package com.workwave.service.traffic;



import com.workwave.common.traffic.myInfoPage;
import com.workwave.dto.traffic.request.totalTrafficInfoDto;
import com.workwave.dto.traffic.response.StationViewResponseDto;
import com.workwave.dto.traffic.response.trafficInfoDto;
import com.workwave.mapper.traffic.trafficMapper;
import com.workwave.mapper.traffic.trafficViewMapper;
import com.workwave.util.LoginUtil;
import lombok.AllArgsConstructor;
import lombok.Builder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Builder
public class trafficService {

    private final trafficMapper trafficMapper;
    private final TrafficViewService trafficViewService;
    private final trafficViewMapper trafficViewMapper;

    public boolean save(trafficInfoDto trafficInfo, HttpSession session) {

        trafficInfoDto newTraffic = trafficInfo.builder()
                .userId(trafficInfo.getUserId())
                .arrival(trafficInfo.getArrival())
                .departure(trafficInfo.getDeparture())
                .station(trafficInfo.getStation())
                .needTime(trafficInfo.getNeedTime())
                .regDateTime(LocalDateTime.now())
                .build();

        String userId = LoginUtil.getLoggedInUser(session).getUserId();

        List<totalTrafficInfoDto> result = trafficMapper.findOne(userId);
        System.out.println(result);
//        List<StationViewResponseDto> result = trafficViewMapper.favoriteFindStation(userId);

        boolean foundExisting = false;

        for (totalTrafficInfoDto dto : result) {
            if (userId.equals(dto.getUserId())) {

                if (dto.getDeparture().equals(newTraffic.getDeparture()) && dto.getArrival().equals(newTraffic.getArrival())) {
                    trafficViewService.findOneAndUpdateViewCount(userId);
                    System.out.println("계정이 같은 것이 있고, 기존 경로 있음");
                    foundExisting = true;
                    break;
                }
            }
        }

        if (!foundExisting) {
            trafficViewService.save(userId, newTraffic);
            System.out.println("기존 기록이 없거나 계정이 다름, 신규 저장");
        }


        return trafficMapper.save(newTraffic);
    }

    public List<totalTrafficInfoDto> findAll(myInfoPage page, HttpSession session, String sort) {
        String userId = LoginUtil.getLoggedInUser(session).getUserId();
        page.setUserId(userId);

        List<totalTrafficInfoDto> trafficList = trafficMapper.findAll(page);

        if ("departure".equals(sort)) {
            trafficList = trafficList.stream()
                    .sorted(Comparator.comparing(totalTrafficInfoDto::getDeparture))
                    .collect(Collectors.toList());
        } else if ("arrival".equals(sort)) {
            trafficList = trafficList.stream()
                    .sorted(Comparator.comparing(totalTrafficInfoDto::getArrival))
                    .collect(Collectors.toList());
        } else if ("regDate".equals(sort)) {
            trafficList = trafficList.stream()
                    .sorted(Comparator.comparing(totalTrafficInfoDto::getRegDateTime))
                    .collect(Collectors.toList());
        }

        return trafficList;
    }

    public int getCount(HttpSession session) {
        String userId = LoginUtil.getLoggedInUser(session).getUserId();

        return trafficMapper.count(userId);
    }
}
