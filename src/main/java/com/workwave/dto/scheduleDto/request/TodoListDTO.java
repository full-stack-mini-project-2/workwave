package com.workwave.dto.scheduleDto.request;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TodoListDTO {

    private int todo_id;
    private String todo_content;
    private LocalDateTime todo_event_date;
    private String todo_status;
    private LocalDateTime todo_createAt;
    private LocalDateTime todo_updateAt;
    private int color_index_id;
    private String department_id;
    private String user_id;

}
