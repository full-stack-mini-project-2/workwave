package com.workwave.service.schedule;

import com.workwave.dto.scheduleDto.request.CalendarEventDTO;
import com.workwave.dto.scheduleDto.request.TeamCalendarEventDTO;
import com.workwave.mapper.scheduleMapper.CalendarMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workwave.dto.scheduleDto.request.CalendarDTO;
import com.workwave.mapper.scheduleMapper.ColorIndexMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalendarService {
        @Autowired
        private CalendarMapper calendarMapper;

        public List<CalendarDTO> getCalendars(String userId) {
            return calendarMapper.getCalendars(userId);
        }

        public List<CalendarEventDTO> getCalendarEvents(String userId) {
            return calendarMapper.getCalendarById(userId);
        }

        public List<TeamCalendarEventDTO> getTeamCalendarEvents(String userId) {
            return calendarMapper.getTeamCalendarEvent(userId);
        }

        public String getUserName(String userId) {
            // Assume this method exists to get the user name
            return calendarMapper.getUserName(userId);
        }
    }
