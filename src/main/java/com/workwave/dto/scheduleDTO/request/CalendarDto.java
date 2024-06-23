package com.workwave.dto.scheduleDTO.request;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
public class CalendarDto {
    private int tCalendarId;
    private String tCalendarName;
    private String userId;

}
