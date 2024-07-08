package com.workwave.service.traffic;


import com.workwave.dto.traffic.response.StationViewResponseDto;
import com.workwave.dto.traffic.response.trafficInfoDto;
import com.workwave.mapper.traffic.trafficViewMapper;
import com.workwave.util.LoginUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

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


        StationViewResponseDto newPerson = StationViewResponseDto.builder()
                .userId(userId)
                .arrival(trafficInfoDto.getArrival())
                .departure(trafficInfoDto.getDeparture())
                .viewCount(0)
                .build();


        trafficViewMapper.saveFavoriteStation(newPerson);

        return newPerson;
    }

    public List<StationViewResponseDto> findOneAndUpdateViewCount(String userId, trafficInfoDto newTraffic) {
        List<StationViewResponseDto> dtoList = trafficViewMapper.findOne(userId);


        for (StationViewResponseDto dto : dtoList) {
            if(newTraffic.getDeparture().equals(dto.getDeparture()) && newTraffic.getArrival().equals(dto.getArrival())){
                int newViewCount = dto.getViewCount() + 1;
                dto.setViewCount(newViewCount);
                trafficViewMapper.updateViewCounts(dto); // 업데이트 메소드 호출
            }
        }
        return dtoList;
    }



}
