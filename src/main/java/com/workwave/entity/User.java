package com.workwave.entity;

import lombok.*;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    private String employeeId;
    private String userId;
    private String userPassword;
    private String userName;
    private String userPosition;
    private String userEmail;
    private String userCreateAt;
    private String accessLevel;
    private String departmentId;
}
