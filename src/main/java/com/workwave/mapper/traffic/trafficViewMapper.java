package com.workwave.mapper.trafficMapper;

import com.workwave.dto.traffic.response.StationViewResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;


@Mapper
public interface trafficViewMapper {

    List<StationViewResponseDto> saveFavoriteStation(String userId);

    List<StationViewResponseDto> favoriteFindStation(String userId);

    List<StationViewResponseDto> findOne(String userId);

}
