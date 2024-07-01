package com.workwave.mapper.traffic;

import com.workwave.dto.traffic.response.StationViewResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;


@Mapper
public interface trafficViewMapper {

    boolean saveFavoriteStation(StationViewResponseDto userId);

    List<StationViewResponseDto> favoriteFindStation(String userId);

    List<StationViewResponseDto> findOne(String userId);

    void updateViewCounts(List<StationViewResponseDto> dtoList);
}
