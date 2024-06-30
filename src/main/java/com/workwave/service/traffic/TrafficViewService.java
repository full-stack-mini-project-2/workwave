package com.workwave.service.traffic;


import com.workwave.dto.traffic.response.StationViewResponseDto;
import com.workwave.dto.traffic.response.trafficInfoDto;
import com.workwave.mapper.trafficMapper.trafficViewMapper;
import com.workwave.util.LoginUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
@AllArgsConstructor
public class TrafficViewService {

    private final trafficViewMapper trafficViewMapper;

    public List<StationViewResponseDto> view(HttpSession session){

        String userId = LoginUtil.getLoggedInUser(session).getUserId();

        List<StationViewResponseDto> favoriteFindStation = trafficViewMapper.favoriteFindStation(userId);

        return favoriteFindStation;

    };

    public StationViewResponseDto save(String userId, trafficInfoDto trafficInfoDto) {

        List<StationViewResponseDto> favoriteFindStation = trafficViewMapper.favoriteFindStation(userId);

        System.out.println(favoriteFindStation);

        StationViewResponseDto newPerson = StationViewResponseDto.builder()
                .userId(userId)
                .arrival(trafficInfoDto.getArrival())
                .departure(trafficInfoDto.getDeparture())
                .viewCount(0)
                .build();

        return newPerson;
    }

    public List<StationViewResponseDto> findOne(String userId) {
        List<StationViewResponseDto> dto = trafficViewMapper.findOne(userId);

        for (StationViewResponseDto dtoList : dto) {
            int newViewCount = dtoList.getViewCount() + 1;
            dtoList.setViewCount(newViewCount);
        }

        return dto;
    }

}
