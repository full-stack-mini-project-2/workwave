package com.workwave.dto.scheduleDto.request;

import lombok.*;

import java.time.LocalDateTime;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
public class CalendarDTO {
    private int calendarId;
    private String calendarName;
    private LocalDateTime createdAt;
    private String userId;

}
