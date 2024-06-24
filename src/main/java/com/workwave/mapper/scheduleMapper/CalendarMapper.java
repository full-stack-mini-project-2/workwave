package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.scheduleDTO.request.CalendarsDto;
import com.workwave.dto.scheduleDTO.request.AllMyCalendarEventDto;
import com.workwave.dto.scheduleDTO.request.AllMyTeamCalendarEventDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CalendarMapper {
    //전체 캘린더 중 user의 모든 캘린더 가져오기
    List<CalendarsDto> getMyAllCalendars(String userId);

    //개인 캘린더 일정 목록 구하기
    List<AllMyCalendarEventDto> getMyAllCalendarEvents(String userId);

    //팀 캘린더 일정 목록 유저 구하기
    List<AllMyTeamCalendarEventDto> getMyAllTeamCalendarEvents(String userId);

    //개인 캘린더 일정 추가하기
    boolean insertCalendarEvent(AllMyCalendarEventDto calendarEvent);

    //팀 캘린더 일정 추가하기
    boolean insertTeamCalendarEvent(AllMyTeamCalendarEventDto TeamCalendarEvent);

    //개인, 팀 캘린더 일정 삭제하기
    void deleteCalendarEvent(int calendarEventId);

    //개인, 팀 캘린더 일정 수정하기
//    void updateCalendarEvent(CalendarEventDTO calendarEvent);


}
