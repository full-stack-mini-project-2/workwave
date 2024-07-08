package com.workwave.dto.boarddto;

import com.workwave.entity.board.Board;
import lombok.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@EqualsAndHashCode
@Builder
public class BoardUpdateDto {

    private int boardId;
    private String newContent;
    private LocalDateTime boardUpdatedAt = LocalDateTime.now();

}
