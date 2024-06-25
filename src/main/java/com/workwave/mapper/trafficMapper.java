package com.workwave.mapper;

import com.workwave.dto.traffic.request.totalTrafficInfoDto;
import com.workwave.dto.traffic.response.trafficInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface trafficMapper {

    // 선택 교통내용 저장
    boolean save(trafficInfo trafficInfo);

    // 선택한 교통내용 불러오기
    List<totalTrafficInfoDto> findAll();
}
