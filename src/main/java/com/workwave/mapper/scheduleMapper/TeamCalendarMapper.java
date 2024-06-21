package com.workwave.mapper.scheduleMapper;

import com.workwave.entity.schedule.TeamCalendar;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TeamCalendarMapper {
    boolean save(TeamCalendar teamCalendar);

}
