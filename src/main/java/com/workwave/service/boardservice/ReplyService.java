package com.workwave.service.boardservice;

import com.workwave.dto.replydto.ReplyDetailDto;
import com.workwave.dto.replydto.ReplyListDto;
import com.workwave.dto.replydto.ReplyWriteDto;
import com.workwave.entity.board.Reply;
import com.workwave.mapper.boardmapper.ReplyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    // 댓글 목록 전체조회
    public ReplyListDto getReplies(int boardId) {

        List<Reply> replies = replyMapper.replies(boardId);

        List<ReplyDetailDto> dtoList = replies.stream()
                .map(r -> new ReplyDetailDto(r))
                .collect(Collectors.toList());

        return ReplyListDto.builder()
                .replies(dtoList)
                .build();
    }


    public boolean save(ReplyWriteDto dto) {

//        replyMapper.save()

        return false;
    }
}
