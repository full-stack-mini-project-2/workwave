package com.workwave.dto.boarddto;

import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.checkerframework.checker.units.qual.A;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter @Setter
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardDetailDto {

    private Long boardId;
    private String userId;
    private String boardTitle;
    private String boardContent;
    private LocalDateTime boardCreatedAt;

    // 날짜 변환 메서드 추가
    public String getFormattedBoardCreatedAt() {
        if (boardCreatedAt != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            return boardCreatedAt.format(formatter);
        } else {
            return "";
        }
    }
}
