package com.workwave.dto.boarddto;

import com.workwave.entity.board.Board;
import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Builder
public class BoardWriteDto {

    private String boardNickname;
    private String boardTitle;
    private String boardContent;
    private String boardPassword;

    public Board toEntity() {
        return Board.builder()
                .boardTitle(this.boardTitle)
                .boardNickname(this.boardNickname)
                .boardContent(this.boardContent)
                .boardPassword(this.boardPassword)
                .build();
    }
}
