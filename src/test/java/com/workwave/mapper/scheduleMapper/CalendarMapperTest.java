package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.schedule_dto.request.CalendarsDto;
import com.workwave.mapper.scheduleMapper.CalendarMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class CalendarMapperTest {
    @Autowired
    CalendarMapper calendarMapper;
}

