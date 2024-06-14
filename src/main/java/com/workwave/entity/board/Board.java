package com.workwave.entity.board;

import lombok.*;

import java.time.LocalDateTime;

@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
//@Builder
public class Board {

    private String userId;
    private String boardTitle;
    private String boardContent;
    private String boardPassword;
    private LocalDateTime boardCreateAt = LocalDateTime.now();
    private LocalDateTime boardUpdateAt;


//    public Board(String userId) {
//        this.userId = "admin";
//    }
}
