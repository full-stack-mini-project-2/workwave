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
    private String account;
    @Setter
    private String password;
    private String userName;
    private String userPosition;
    private String userEmail;


    private String accessLevel;
    private String departmentId;
    @Setter
    private String profileImage;
    @Setter
    private String userCreateAt;
}

