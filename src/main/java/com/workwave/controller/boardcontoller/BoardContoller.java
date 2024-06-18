package com.workwave.controller.boardcontoller;

import com.workwave.common.boardpage.Page;
import com.workwave.common.boardpage.PageMaker;
import com.workwave.dto.boarddto.BoardDetailDto;
import com.workwave.dto.boarddto.BoardListDto;
import com.workwave.dto.boarddto.BoardWriteDto;
import com.workwave.entity.board.Board;
import com.workwave.service.boardservice.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
@Slf4j
public class BoardContoller {

    @Autowired
    private final BoardService boardService;

    @GetMapping("/list")
    public String list(Page page, Model model) {

        List<BoardListDto> boardList = boardService.findAll(page);

        PageMaker maker = new PageMaker(page, boardService.boardListCount());

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
