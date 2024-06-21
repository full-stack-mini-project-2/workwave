package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.scheduleDto.request.CalendarDTO;
import com.workwave.entity.schedule.Calendar;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CalendarMapper {
    //캘린더 일정 목록 가져오기
    List<CalendarDTO> getAllCalendars();

    //캘린더 일정 목록 아이디로 구하기
    CalendarDTO getCalendarById(int calendar_id);

    //캘린더 일정 추가하기
    void insertCalendar(CalendarDTO calendar);

    //캘린더 일정 수정하기
    void updateCalendar(CalendarDTO calendar);

    //캘린더 일정 삭제하기
    void deleteCalendar(int calendar_id);
}
