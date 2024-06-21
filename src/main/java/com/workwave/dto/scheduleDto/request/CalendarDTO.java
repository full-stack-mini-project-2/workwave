package com.workwave.dto.scheduleDto.request;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CalendarDTO {
    private int calendar_id;
    private int event_id;
    private LocalDateTime event_date;
    private String event_title;
    private String event_description;
    private LocalDateTime c_createAt;
    private LocalDateTime c_updateAt;
    private int color_index_id;
    private int team_todo_id;
    private int notice_id;
    private String department_id;
    private String user_id;
    private int todo_id;

}
