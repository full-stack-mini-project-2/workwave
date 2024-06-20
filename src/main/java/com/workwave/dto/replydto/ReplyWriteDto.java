package com.workwave.dto.replydto;

import com.workwave.entity.board.Board;
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
public class ReplyWriteDto {

//    컨트롤러의  @Validated 과 함께 유효성 검사 추후 추가  ex)
//    @NotNull(message = "이름은 필수 항목입니다.")
//    @Size(min = 2, max = 30, message = "이름은 2자 이상 30자 이하로 입력해주세요.")
    private String nickName;
    private String replyContent;
    private String replyPassword;

    public Reply toEntity() {
        return Reply.builder()
                .replyContent(this.replyContent)
                .replyPassword(this.replyPassword)
                .nickName(this.nickName)
                .build();
    }

}
