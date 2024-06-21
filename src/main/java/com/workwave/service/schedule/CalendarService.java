package com.workwave.service.schedule;

import com.workwave.mapper.scheduleMapper.CalendarMapper;
import org.springframework.stereotype.Service;

import com.workwave.dto.scheduleDto.request.CalendarDTO;
import com.workwave.mapper.scheduleMapper.ColorIndexMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalendarService {
    private final CalendarMapper calendarMapper;

    public CalendarService(CalendarMapper calendarMapper) {
        this.calendarMapper = calendarMapper;
    }

    public List<CalendarDTO> getAllCalendars() {
        return calendarMapper.getAllCalendars();
    }

    public CalendarDTO getCalendarById(int calendar_id) {
        return calendarMapper.getCalendarById(calendar_id);
    }

    public void insertCalendar(CalendarDTO calendar) {
        calendarMapper.insertCalendar(calendar);
    }

    public void updateCalendar(CalendarDTO calendar) {
        calendarMapper.updateCalendar(calendar);
    }

    public void deleteCalendar(int calendar_id) {
        calendarMapper.deleteCalendar(calendar_id);
    }
}
