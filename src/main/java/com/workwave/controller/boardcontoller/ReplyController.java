package com.workwave.controller.boardcontoller;

import com.workwave.dto.replydto.ReplyListDto;
import com.workwave.dto.replydto.ReplyWriteDto;
import com.workwave.service.boardservice.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/reply")
@RequiredArgsConstructor
@Slf4j
public class ReplyController {

    private final ReplyService replyService;

    //    @GetMapping("/{bno}/page/{pageNo}")
// 댓글 목록 조회
    @GetMapping("/{bno}")
    public ResponseEntity<?> replies(@PathVariable("bno") int boardId, HttpSession session) {

        log.info("/reply/{} : GET", boardId);

        ReplyListDto replies = replyService.getReplies(boardId);

        return ResponseEntity
                .ok()
                .body(replies);
    }

    // 댓글 생성 요청
    @PostMapping
    public ResponseEntity<?> saveReply(@RequestBody ReplyWriteDto dto)
    {

        log.info("ReplyWriteDto: {}", dto);

        boolean flag = replyService.save(dto);
        
        return ResponseEntity
                .ok()
                .body(null);
//                .body(replyService.getReplies(dto.getBno(), new Page(1, 10)));
    }

}
