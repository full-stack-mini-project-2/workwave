package com.workwave.controller.boardcontoller;

import com.workwave.dto.replydto.ReplyListDto;
import com.workwave.dto.replydto.ReplyUpdateDto;
import com.workwave.dto.replydto.ReplyWriteDto;
import com.workwave.service.boardservice.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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
    public ResponseEntity<?> saveReply(@RequestBody @Valid ReplyWriteDto dto) {

        log.info("ReplyWriteDto: {}", dto);

        // flag를 통하여 에러 검사
        boolean flag = replyService.save(dto);

        return ResponseEntity
                .ok()
                .body(replyService.getReplies(dto.getBoardId()));
    }

    // 댓글 수정 요청
    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH})
    public ResponseEntity<?> updateReply(@RequestBody @Valid ReplyUpdateDto dto) {

        log.info("ReplyUpdateDto: {}", dto);

        boolean flag = replyService.update(dto);

        if (flag) {
            return ResponseEntity
                    .ok()
                    .body(replyService.getReplies(dto.getBoardId()));
        } else {
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("댓글 업데이트에 실패했습니다.");
        }

    }

}
