package com.workwave.mapper;

import com.workwave.entity.TeamCalendar;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TeamCalendarMapper {
    boolean save(TeamCalendar teamCalendar);

}
