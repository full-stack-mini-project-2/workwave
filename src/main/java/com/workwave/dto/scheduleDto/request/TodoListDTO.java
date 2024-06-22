package com.workwave.dto.scheduleDto.request;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TodoListDTO {

    private int todoId;
    private String todoContent;
    private String todoStatus;
    private LocalDateTime todoCreateAt;
    private LocalDateTime todoUpdateAt;
    private Integer colorIndexId; // Integer로 선언하여 null 값을 허용
    private String userId;

}
