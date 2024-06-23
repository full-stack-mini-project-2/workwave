package com.workwave.service.boardservice;

import com.workwave.dto.replydto.ReplyDetailDto;
import com.workwave.dto.replydto.ReplyListDto;
import com.workwave.dto.replydto.ReplyUpdateDto;
import com.workwave.dto.replydto.ReplyWriteDto;
import com.workwave.entity.board.Board;
import com.workwave.entity.board.Reply;
import com.workwave.mapper.boardmapper.BoardMapper;
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
    @Autowired
    private BoardMapper boardMapper;

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

        Reply reply = dto.toEntity();

        boolean save = replyMapper.save(reply);

        int boardId = reply.getBoardId();

        Board upatedBoard = boardMapper.findOne(boardId);

        upatedBoard.setReplyCount(upatedBoard.getReplyCount() + 1);

        boardMapper.updateCount(upatedBoard);

        return save;
    }

    public boolean update(ReplyUpdateDto dto) {

        Reply original = replyMapper.findOne(dto.getReplyId());

        if (original.getReplyPassword().equals(dto.getEditReplyPassword())) {
            Reply modifyReply = dto.toEntity();
            log.info(modifyReply.toString());
            boolean update = replyMapper.update(modifyReply);
            return update;
        } else {
            return false;
        }

    }
}
