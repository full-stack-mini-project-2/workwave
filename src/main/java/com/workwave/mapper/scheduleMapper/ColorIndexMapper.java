package com.workwave.mapper.scheduleMapper;

import com.workwave.entity.schedule.ColorIndex;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ColorIndexMapper {
    //색 이름 구하기
    long getColorIdByName(String colorName);

    //색 저장하기
   boolean saveColorIndex(ColorIndex colorINdex);
}
