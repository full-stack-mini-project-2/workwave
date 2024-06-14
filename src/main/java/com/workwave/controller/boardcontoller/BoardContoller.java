package com.workwave.controller.boardcontoller;

import com.workwave.dto.boarddto.BoardWriteDto;
import com.workwave.service.boardservice.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
@Slf4j
public class BoardContoller {

    @Autowired
    private final BoardService boardService;

    @GetMapping("/list")
    public String list() {


        return "board/boardList";
    }

    @GetMapping("/write")
    public String write() {

        return "board/boardWrite";
    }

    @PostMapping("/write")
    public String register(BoardWriteDto dto) {

        boardService.save(dto);

        return "redirect:/board/list";
    }
}
