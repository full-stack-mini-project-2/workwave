package com.workwave.dto.replydto;

import com.workwave.entity.board.Reply;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Builder
public class ReplyUpdateDto {

    private int replyId;
    private int boardId;
    private String editReplyContent;
    private String editReplyPassword;
    private LocalDateTime replyUpdatedAt;

    public Reply toEntity() {
        return Reply.builder()
                .replyContent(this.editReplyContent)
                .replyUpdatedAt(this.getReplyUpdatedAt())
                .build();
    }

}
