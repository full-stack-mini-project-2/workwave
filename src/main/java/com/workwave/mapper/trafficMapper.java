package com.workwave.mapper;

import com.workwave.common.traffic.myInfoPage;
import com.workwave.dto.traffic.request.totalTrafficInfoDto;
import com.workwave.dto.traffic.response.trafficInfoDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface trafficMapper {

    // 선택 교통내용 저장
    boolean save(trafficInfoDto trafficInfo);

    // 선택한 교통내용 불러오기
    List<totalTrafficInfoDto> findAll(myInfoPage page);

    int count();
}
