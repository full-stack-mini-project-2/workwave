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
    private LocalDateTime boardUpdateAt = LocalDateTime.now();

    // 날짜 변환 메서드 추가
    public String getFormattedBoardUpdateAt() {
        if (boardUpdateAt != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            return boardUpdateAt.format(formatter);
        } else {
            return "";
        }
    }

    public Board toEntity() {
        return Board.builder()
                .boardId(this.boardId)
                .boardContent(this.newContent)
                .boardUpdateAt(this.boardUpdateAt)
                .build();
    }
}
