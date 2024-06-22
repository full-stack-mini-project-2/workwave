package com.workwave.dto.scheduleDTO.request;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
public class CalendarDTO {
    private int calendarId;
    private String calendarName;
    private int tCalendarId;
    private String tCalendarName;
    private String userId;

}
