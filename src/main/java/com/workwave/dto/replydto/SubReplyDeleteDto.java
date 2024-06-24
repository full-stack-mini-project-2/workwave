package com.workwave.dto.replydto;

import lombok.*;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Builder
public class SubReplyDeleteDto {

    private int replyId;
    private int subReplyId;
    private String replyDeletePassword;

}
