package com.workwave.dto.scheduleDTO.request;

import lombok.*;

//@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
@ToString
public class CalendarsDto {
    private int calendarId;
    private String calendarName;
    private int tCalendarId;
    private String tCalendarName;
    private String userId;

    public int getCalendarId() {
        return calendarId;
    }

    public String getCalendarName() {
        return calendarName;
    }

    public String gettCalendarName() {
        return tCalendarName;
    }

    public int gettCalendarId() {
        return tCalendarId;
    }

    public String getUserId() {
        return userId;
    }
}
