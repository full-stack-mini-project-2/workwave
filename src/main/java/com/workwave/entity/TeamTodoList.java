package com.workwave.entity;

import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@EqualsAndHashCode
@ToString
@Builder
public class TeamTodoList {

    private int teamTodoId;
    private String teamTodoContent;
    private LocalDateTime teamTodoDate;
    private int colorIndexId;
    private int noticeId;
    private String departmentId;
    private String userId;


}
