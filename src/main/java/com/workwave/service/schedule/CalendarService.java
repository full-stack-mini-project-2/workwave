package com.workwave.service.schedule;

import com.workwave.dto.scheduleDTO.request.AllMyCalendarEventDto;
import com.workwave.dto.scheduleDTO.request.CalendarsDto;
import com.workwave.dto.scheduleDTO.request.TeamCalendarEventDto;
import com.workwave.mapper.scheduleMapper.CalendarMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class CalendarService {

        private final CalendarMapper calendarMapper;

        //user의 모든 캘린더 목록 (총 2개)
        public List<CalendarsDto> getMyCalendars(String userId) {
            return calendarMapper.getMyAllCalendars(userId);
        }

        //개인 캘린더 일정 목록 아이디로 구하기
        public List<AllMyCalendarEventDto> getEvents(String userId) {
            return calendarMapper.getMyAllCalendarEvents(userId);
        }

       //팀 캘린더 일정 목록 아이디로 구하기
       public List<TeamCalendarEventDto> getTeamEvents(String userId) {
        return calendarMapper.getMyTeamCalendarEvents(userId);
       }

        //개인 캘린더 일정 추가


        //팀 캘린더 일정 추가


        //캘린더 일정 수정


        //캘린더 일정 삭제
    }
