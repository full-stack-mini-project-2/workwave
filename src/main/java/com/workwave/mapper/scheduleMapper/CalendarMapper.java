package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.scheduleDto.request.CalendarDTO;
import com.workwave.dto.scheduleDto.request.CalendarEventDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CalendarMapper {
    //전체 캘린더 중 user의 모든 캘린더 가져오기
    List<CalendarDTO> getCalendars(String userId);

    //캘린더 일정 목록 아이디로 구하기
    CalendarEventDTO getCalendarById(int calendarId);

    //캘린더 일정 추가하기
    boolean insertCalendarEvent(CalendarEventDTO calendarEvent);

    //캘린더 일정 수정하기
    void updateCalendarEvent(CalendarEventDTO calendarEvent);

    //캘린더 일정 삭제하기
    void deleteCalendarEvent(int calendarEventId);
}
