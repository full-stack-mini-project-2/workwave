package com.workwave.service.traffic;



import com.workwave.common.traffic.myInfoPage;
import com.workwave.dto.traffic.request.totalTrafficInfoDto;
import com.workwave.dto.traffic.response.trafficInfoDto;
import com.workwave.mapper.trafficMapper;
import lombok.AllArgsConstructor;
import lombok.Builder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@AllArgsConstructor
@Builder
public class trafficService {

    private final trafficMapper trafficMapper;

    public boolean save(trafficInfoDto trafficInfo){

        trafficInfoDto newTraffic = trafficInfo.builder()
                .arrival(trafficInfo.getArrival())
                .departure(trafficInfo.getDeparture())
                .station(trafficInfo.getStation())
                .needTime(trafficInfo.getNeedTime())
                .regDateTime(LocalDateTime.now())
                .build();

        return trafficMapper.save(newTraffic);
    }

    public List<totalTrafficInfoDto> findAll(myInfoPage page){

        List<totalTrafficInfoDto> trafficList = trafficMapper.findAll(page);


        return trafficList;
    }
}
