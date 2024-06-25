package com.workwave.service.boardservice;

import com.workwave.dto.replydto.ReplyWriteDto;
import com.workwave.entity.board.Reply;
import com.workwave.mapper.boardmapper.BoardMapper;
import com.workwave.mapper.boardmapper.ReplyMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest
class ReplyServiceTest {

    @Mock
    private ReplyMapper replyMapper;

    @InjectMocks
    private ReplyService replyService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void save100Replies() {
        for (int i = 1; i <= 100; i++) {
            // Given
            ReplyWriteDto dto = new ReplyWriteDto();
            dto.setReplyContent("댓글 내용 " + i);
            dto.setNickName("닉네임 " + i);
            dto.setBoardId(195); // 예시로 보드 아이디를 1로 설정
            dto.setReplyPassword("password" + i);

            Reply reply = dto.toEntity();
            when(replyMapper.save(reply)).thenReturn(true);
            boardMapper.updateCount();
            // When
            boolean result = replyService.save(dto);

            // Then
            assertTrue(result);
        }

    }
}
