package com.workwave.controller.boardcontoller;

import com.workwave.common.boardpage.PageMaker;
import com.workwave.common.boardpage.Search;
import com.workwave.dto.boarddto.BoardDetailDto;
import com.workwave.dto.boarddto.BoardListDto;
import com.workwave.dto.boarddto.BoardWriteDto;
import com.workwave.service.boardservice.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
@Slf4j
public class BoardController {

    private final BoardService boardService;

    @GetMapping("/list")
    public String list(Search search, Model model) {
        List<BoardListDto> boardList = boardService.findAll(search);
        // 검색 조건에 따른 게시물 수를 계산합니다.
        int totalCount = boardService.boardListCount(search);
        PageMaker maker = new PageMaker(search, totalCount);

        log.info("Total Count: {}", totalCount);

        model.addAttribute("boards", boardList);
        model.addAttribute("maker", maker);

        return "board/boardList";
    }

    @GetMapping("/write")
    public String write() {

        return "board/boardWrite";
    }

    @PostMapping("/write")
    public String register(BoardWriteDto dto) {
        log.info("Received DTO: {}", dto);
        if (boardService.save(dto)) {
            return "redirect:/board/list";
        } else {
            return "error";
        }
    }

    @GetMapping("/detail")
    public String findOne(@RequestParam("bno") long boardId, Model model) {

        BoardDetailDto board = boardService.findOne(boardId);

        model.addAttribute("board", board);

        return "board/boardDetail";
    }
}
