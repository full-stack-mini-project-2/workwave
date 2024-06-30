package com.workwave.service.schedule;

import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
import com.workwave.dto.schedule_dto.request.CalendarsDto;
import com.workwave.dto.schedule_dto.request.AllMyTeamCalendarEventDto;
import com.workwave.entity.schedule.CalendarEvent;
import com.workwave.entity.schedule.TeamCalendar;
import com.workwave.mapper.scheduleMapper.CalendarMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset; // 수정: ZoneOffset을 import 추가
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class CalendarService {

    private final CalendarMapper calendarMapper;

    // 로그인 시 달력 유무 체크
    @Transactional
    public void checkAndSetupCalendars(String userId, String departmentId) {
        // 개인 캘린더가 존재하는지 확인
        Integer personalCalendarCount = calendarMapper.countPersonalCalendar(userId);
        if (personalCalendarCount == 0) {
            // 개인 캘린더 생성
            Map<String, Object> params = new HashMap<>();
            params.put("userId", userId);
            params.put("calendarName", "Personal Calendar");
            calendarMapper.insertPersonalCalendar(params);
        }

        // 팀 캘린더와의 연결 확인 및 설정
        TeamCalendar teamCalendar = calendarMapper.getTeamCalendarByDepartmentId(departmentId);
        if (teamCalendar != null) {
            // 팀 캘린더를 사용자가 조회할 수 있도록 설정 (필요한 경우에만)
            Integer teamCalendarCount = calendarMapper.countUserTeamCalendar(userId);
            if (teamCalendarCount == 0) {
                Map<String, Object> params = new HashMap<>();
                params.put("userId", userId);
                params.put("calendarName", "Personal Calendar");
                calendarMapper.insertPersonalCalendar(params); // 수정: 여기서는 팀 캘린더가 아니라 개인 캘린더를 추가해야 할 듯 합니다.
            }
        }
    }

    // user의 모든 캘린더 목록 (총 2개)
    public List<AllMyCalendarEventDto> getCalendars(String userId) {
        return calendarMapper.getMyAllCalendars(userId);
    }

    public List<AllMyCalendarEventDto> getMyEventsForMonth(String userId, int year, int month) {
        // startDate는 해당 연도의 해당 월의 첫 번째 날
        String startDate = String.format("%d-%02d-01", year, month);
        // endDate는 해당 연도의 해당 월의 마지막 날
        String endDate = String.format("%d-%02d-%02d", year, month, getLastDayOfMonth(year, month));
        return calendarMapper.getCalendarEventsForPeriod(userId, startDate, endDate);
    }

    // 해당 연도와 월의 마지막 날짜를 가져오는 헬퍼 메서드
    private int getLastDayOfMonth(int year, int month) {
        Calendar cal = Calendar.getInstance();
        cal.set(year, month - 1, 1);
        return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    }

    // 개인 캘린더 일정 목록
    public List<AllMyCalendarEventDto> getMyAllEvents(String userId) {
        return calendarMapper.getMyAllCalendarEvents(userId);
    }

    @Transactional
    public AllMyCalendarEventDto addEvent(AllMyCalendarEventDto addEventDto, String userId, String userName) {
        LocalDateTime eventDateTime = LocalDate.parse(addEventDto.getCalEventDate()).atStartOfDay();

        AllMyCalendarEventDto newEvent = AllMyCalendarEventDto.builder()
                .calEventDate(eventDateTime.toString())
                .calEventTitle(addEventDto.getCalEventTitle())
                .calEventDescription(addEventDto.getCalEventDescription())
                .calEventCreateAt(LocalDateTime.now())
                .calEventUpdateAt(LocalDateTime.now())
                .userId(userId)
                .userName(userName)
                .colorIndexId(addEventDto.getColorIndexId())
                .build();

        calendarMapper.insertCalendarEvent(newEvent); // 실제로 이벤트를 삽입하는 코드
        return newEvent;
    }

    // 개인, 팀 캘린더 일정 수정
    @Transactional
    public boolean updateCalEvent(AllMyCalendarEventDto calendarEvent) {
        try {
            // 기존 이벤트를 가져오기
            AllMyCalendarEventDto existingEvent = calendarMapper.findOneMyCalEvent(calendarEvent.getCalEventId());

            // 업데이트할 필드 설정
            calendarEvent.setCalEventUpdateAt(LocalDateTime.now());

            if (calendarEvent.getColorIndexId() == null) {
                if (existingEvent.getColorIndexId() == null) {
                    calendarEvent.setColorIndexId(getDefaultColorIndex());
                } else {
                    calendarEvent.setColorIndexId(existingEvent.getColorIndexId());
                }
            }

            calendarMapper.updateMyCalEvent(calendarEvent);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 개인, 팀 캘린더 일정 삭제
    @Transactional
    public void deleteMyCalEvent(int calEventId) {
        calendarMapper.deleteCalendarEvent(calEventId);
    }

    // 팀 캘린더 일정 목록
    public List<AllMyTeamCalendarEventDto> getMyTeamEvents(String departmentId) {
        return calendarMapper.getMyAllTeamCalendarEvents(departmentId);
    }

    private Integer getDefaultColorIndex() {
        // Return default color index
        return 1; // 예시로 기본 색인 인덱스를 1로 설정
    }

}
