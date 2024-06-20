package com.workwave.entity.board;

import lombok.*;

import java.time.LocalDateTime;

@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Builder
public class Board {

    private int boardId;
    private String userId;
    private String boardTitle;
    private String boardContent;
    private String boardPassword;
    private LocalDateTime boardCreatedAt = LocalDateTime.now();
    private LocalDateTime boardUpdatedAt;

}