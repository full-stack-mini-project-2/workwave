package com.workwave.entity.schedule;

import lombok.*;
import org.apache.tomcat.jni.Local;

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
    private LocalDateTime teamEventDate;
    private String teamTodoStatus;
    private LocalDateTime teamTodoCreateAt;
    private LocalDateTime teamTodoUpdateAt;
    private Integer colorIndexId;
    private String departmentId;
    private String userId;


}
