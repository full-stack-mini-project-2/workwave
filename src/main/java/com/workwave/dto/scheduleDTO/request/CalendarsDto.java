package com.workwave.dto.scheduleDTO.request;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
@ToString
public class CalendarsDto {
    private int tCalendarId;
    private String tCalendarName;
    private String userId;

}
