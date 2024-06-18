package com.workwave.mapper;

import com.workwave.entity.Calendar;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CalendarMapper {
    boolean save(Calendar calendar);
}
