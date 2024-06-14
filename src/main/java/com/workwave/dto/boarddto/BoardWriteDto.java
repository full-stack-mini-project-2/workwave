package com.workwave.dto.boarddto;

import com.workwave.entity.board.Board;
import lombok.*;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Builder
public class BoardWriteDto {

    private String userId;
    private String boardTitle;
    private String boardContent;
    private String boardPassword;

    public Board toEntity() {
        Board b = new Board();
        b.setUserId(this.userId);
        b.setBoardContent(this.boardContent);
        b.setBoardTitle(this.boardTitle);
        b.setBoardPassword(this.boardPassword);
        return b;
    }
}
