package com.workwave.controller.boardcontoller;

import com.workwave.common.boardpage.PageMaker;
import com.workwave.common.boardpage.Search;
import com.workwave.dto.boarddto.BoardDetailDto;
import com.workwave.dto.boarddto.BoardListDto;
import com.workwave.dto.boarddto.BoardUpdateDto;
import com.workwave.dto.boarddto.BoardWriteDto;
import com.workwave.entity.board.Board;
import com.workwave.service.boardservice.BoardService;
import com.workwave.util.LoginUtil;
import com.workwave.util.PasswordUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
@Slf4j
public class BoardController {

    private final BoardService boardService;

    @GetMapping("/list")
    public String list(Search search,
                       Model model,
                       HttpSession session) {

        if (search.getType() != null && search.getType().equals("id")) {
            search.setKeyword(LoginUtil.getLoggedInUserAccount(session));
        }

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
    public String register(BoardWriteDto dto, HttpSession session) {

        log.info("Received DTO: {}", dto);

        if (boardService.save(dto, session)) {
            return "redirect:/board/list";
        } else {
            return "error";
        }
    }

    @GetMapping("/detail")
    public String findOne(@RequestParam("bno") int boardId,
                          Model model,
                          HttpServletRequest request,
                          HttpSession session) {

        boardService.updateViewCount(boardId);

        BoardDetailDto board = boardService.findOne(boardId);

        String account = LoginUtil.getLoggedInUserAccount(session);

        model.addAttribute("board", board);
        model.addAttribute("id", account);

        // 게시물 조회를 누를때 주소값을 저장해서 목록으로 돌아갈때 다시 리다이렉트
        String referer = request.getHeader("Referer");
        if (referer != null && referer.contains("/list")) {
            request.getSession().setAttribute("referer", referer);
        }

        log.info("referer: {}", referer);
        log.info("account: {}", account);

        return "board/boardDetail";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("bno") int boardId) {

        BoardDetailDto board = boardService.findOne(boardId);

        int targetId = board.getBoardId();

        boardService.delete(targetId);

        return "redirect:/board/list";
    }

    @GetMapping("/pwcheck")
    public String PasswordCheck() {

        return "board/boardPwCheck";
    }

    @PostMapping("/pwcheck")
    public String isEqualPw(@RequestParam("bno") int boardId,
                            @RequestParam("action") String action,
                            @RequestParam("boardPassword") String inputPassword,
                            Model model) {

        BoardDetailDto board = boardService.findOne(boardId);

        log.info(action);

        // 해싱된 비밀번호 검증
        if (PasswordUtil.checkPassword(inputPassword, board.getBoardPassword())) {
            if ("update".equals(action)) {
                return "redirect:/board/update?bno=" + boardId;
            } else if ("delete".equals(action)) {
                return "redirect:/board/delete?bno=" + boardId;
            }
        }
        
        model.addAttribute("error", "비밀번호가 일치하지 않습니다.");

        return "board/boardPwCheck";
    }

    @GetMapping("/update")
    public String modify(@RequestParam("bno") int boardId,
                         Model model,
                         HttpSession session) {

        BoardDetailDto board = boardService.findOne(boardId);

        model.addAttribute("board", board);

        return "board/boardUpdate";
    }

    @PostMapping("/update")
    public String update(@RequestParam("bno") int boardId,
                         BoardUpdateDto dto) {

        log.info("Received DTO: {}", dto);

        boardService.update(dto);

        return "redirect:/board/detail?bno=" + boardId;

    }

    @PostMapping("/upLike")
    @ResponseBody
    public ResponseEntity<?> upLikeCount(@RequestParam(value = "bno") Integer boardId,
                                         HttpSession session) {

        if (boardId == null) {
            return ResponseEntity.badRequest().body("boardId parameter is required.");
        }

        // 세션에서 아이디 검증 후 좋아요 수 조절
        boardService.upLikeCount(boardId);

        return ResponseEntity
                .ok()
                .body(boardService.findOne(boardId));

    }

    @PostMapping("/downLike")
    @ResponseBody
    public ResponseEntity<?> downLikeCount(@RequestParam(value = "bno") Integer boardId,
                                         HttpSession session) {

        if (boardId == null) {
            return ResponseEntity.badRequest().body("boardId parameter is required.");
        }

        // 세션에서 아이디 검증 후 좋아요 수 조절
        boardService.downLikeCount(boardId);

        return ResponseEntity
                .ok()
                .body(boardService.findOne(boardId));

    }

    @PostMapping("/upDislike")
    @ResponseBody
    public ResponseEntity<?> upDislikeCount(@RequestParam(value = "bno") Integer boardId) {

        if (boardId == null) {
            return ResponseEntity.badRequest().body("boardId parameter is required.");
        }

        // 세션에서 아이디 검증 후 좋아요 수 조절
        boardService.upDislikeCount(boardId);

        return ResponseEntity
                .ok()
                .body(boardService.findOne(boardId));
    }

    @PostMapping("/downDislike")
    @ResponseBody
    public ResponseEntity<?> downDislikeCount(@RequestParam(value = "bno") Integer boardId) {

        if (boardId == null) {
            return ResponseEntity.badRequest().body("boardId parameter is required.");
        }

        // 세션에서 아이디 검증 후 좋아요 수 조절
        boardService.downDislikeCount(boardId);

        return ResponseEntity
                .ok()
                .body(boardService.findOne(boardId));
    }
}
