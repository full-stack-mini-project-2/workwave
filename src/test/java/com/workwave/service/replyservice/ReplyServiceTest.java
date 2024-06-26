package com.workwave.service.replyservice;

import com.workwave.dto.replydto.ReplyWriteDto;
import com.workwave.entity.board.Reply;
import com.workwave.mapper.boardMapper.BoardMapper;
import com.workwave.mapper.boardmapper.ReplyMapper;
import com.workwave.service.boardservice.ReplyService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest
class ReplyServiceTest {

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private BoardMapper boardMapper;

    @Autowired
    private ReplyService replyService;

    @Test
    void save100Replies() {
        for (int i = 1; i <= 100; i++) {
            // Given
            ReplyWriteDto dto = new ReplyWriteDto();
            dto.setReplyContent("댓글 내용 " + i);
            dto.setNickName("닉네임 " + i);
            dto.setBoardId(206); // 예시로 보드 아이디를 1로 설정
            dto.setReplyPassword("password" + i);

            Reply reply = dto.toEntity();

//            when(replyMapper.save(reply)).thenReturn(true);

            // When
            boolean result = replyService.save(dto);

            // Then
            assertTrue(result);
        }

    }
}
