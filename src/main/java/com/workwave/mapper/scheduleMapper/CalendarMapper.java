package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.schedule_dto.request.CalendarsDto;
import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
import com.workwave.dto.schedule_dto.request.AllMyTeamCalendarEventDto;
import com.workwave.entity.schedule.TeamCalendar;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface CalendarMapper {

    // 이번 달 내 캘린더의 이벤트 가져오기
    List<AllMyCalendarEventDto> getCalendarEventsForPeriod(@Param("userId") String userId, @Param("startDate") String startDate, @Param("endDate") String endDate);

    // 전체 캘린더 중 user의 모든 캘린더 가져오기
    List<AllMyCalendarEventDto> getMyAllCalendars(@Param("userId") String userId);

    // 개인 캘린더 일정 목록 구하기
    List<AllMyCalendarEventDto> getMyAllCalendarEvents(@Param("userId") String userId);

    // 팀 캘린더 일정 목록 유저 구하기
    List<AllMyTeamCalendarEventDto> getMyAllTeamCalendarEvents(@Param("userId") String userId);

    // 개인 캘린더 일정 추가하기
    void insertCalendarEvent(AllMyCalendarEventDto calendarEvent);

    // 팀 캘린더 일정 추가하기
    void insertTeamCalendarEvent(AllMyTeamCalendarEventDto teamCalendarEvent);

    // 개인, 팀 캘린더 일정 삭제하기
    void deleteCalendarEvent(@Param("calEventId") int calEventId);

    // 개인, 팀 캘린더 일정 수정하기
    void updateCalEvent(AllMyCalendarEventDto calendarEvent);

    // 로그인 시, 개인 캘린더 개수 확인 (새로 만들지 유무)
    Integer countPersonalCalendar(String userId);

    // 로그인 시, 팀 캘린더 개수 확인 (새로 만들지 유무)
    Integer countUserTeamCalendar(String userId);

    void insertPersonalCalendar(Map<String, Object> params);

    //해당하는 팀 캘린더 유무 확인
    TeamCalendar getTeamCalendarByDepartmentId(String departmentId);

    //팀 캘린더
    void insertUserTeamCalendar(Map<String, Object> teamParams);
}
