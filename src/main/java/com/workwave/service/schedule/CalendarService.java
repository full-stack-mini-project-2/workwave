package com.workwave.service.schedule;

import com.workwave.dto.scheduleDto.request.CalendarEventDTO;
import com.workwave.dto.scheduleDto.request.TeamCalendarEventDTO;
import com.workwave.mapper.scheduleMapper.CalendarMapper;
import com.workwave.mapper.userMapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workwave.dto.scheduleDto.request.CalendarDTO;
import com.workwave.mapper.scheduleMapper.ColorIndexMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class CalendarService {

        private final CalendarMapper calendarMapper;

        //user의 모든 캘린더 목록 (총 2개)
        public List<CalendarDTO> getCalendars(String userId) {
            return calendarMapper.getCalendars(userId);
        }

        //개인 캘린더 일정 목록 아이디로 구하기
        public List<CalendarEventDTO> getEvents(String userId) {
            return calendarMapper.getCalendarEventsById(userId);
        }

       //팀 캘린더 일정 목록 아이디로 구하기
       public List<TeamCalendarEventDTO> getTeamEvents(String userId) {
        return calendarMapper.getTeamCalendarEventsById(userId);
       }

        //개인 캘린더 일정 추가


        //팀 캘린더 일정 추가


        //캘린더 일정 수정


        //캘린더 일정 삭제
    }
