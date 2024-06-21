package com.workwave.mapper.scheduleMapper;

import com.workwave.entity.schedule.Calendar;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CalendarMapper {
    boolean save(Calendar calendar);
}
