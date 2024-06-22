package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.scheduleDTO.request.CalendarDTO;
import com.workwave.dto.scheduleDTO.request.CalendarEventDTO;
import com.workwave.dto.scheduleDTO.request.TeamCalendarEventDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CalendarMapper {
    //전체 캘린더 중 user의 모든 캘린더 가져오기
    List<CalendarDTO> getCalendars(String userId);

    //개인 캘린더 일정 목록 유저 아이디로 구하기
    List<CalendarEventDTO> getCalendarEventsById(String userId);

    //팀 캘린더 일정 목록 유저 아이디로 구하기
    List<TeamCalendarEventDTO> getTeamCalendarEventsById(String userId);

    //개인 캘린더 일정 추가하기
    boolean insertCalendarEvent(CalendarEventDTO calendarEvent);

    //팀 캘린더 일정 추가하기
    boolean insertTeamCalendarEvent(TeamCalendarEventDTO TeamCalendarEvent);

    //개인, 팀 캘린더 일정 삭제하기
    void deleteCalendarEvent(int calendarEventId);

    //개인, 팀 캘린더 일정 수정하기
//    void updateCalendarEvent(CalendarEventDTO calendarEvent);


}
