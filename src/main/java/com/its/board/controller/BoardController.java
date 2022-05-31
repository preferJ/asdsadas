package com.its.board.controller;

import com.its.board.dto.BoardDTO;
import com.its.board.dto.CommentDTO;
import com.its.board.dto.PageDTO;
import com.its.board.service.BoardService;
import com.its.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @Autowired
    private CommentService commentService;

    @GetMapping("/save") // RequestMapping 적용
    public String saveForm(HttpSession session) {
        if (session.getAttribute("memberId") == null) {

            return "memberPages/login";
        }
        return "boardPages/saveFile"; //=> views/board/save.jsp
    }

    @PostMapping("/save") //
    public String save(@ModelAttribute BoardDTO boardDTO) {
        boolean result = boardService.save(boardDTO);
        if (result) {
            return "redirect:/board/findAll";
        } else {
            return "boardPages/save-fail";
        }
    }

    // 목록 출력
    @GetMapping("/findAll")
    public String findAll(Model model) {
        List<BoardDTO> boardDTOList = boardService.findAll();
        model.addAttribute("boardList", boardDTOList);
        return "boardPages/pagingList";
    }

    // 상세조회
    @GetMapping("/detail")
    public String findById(@RequestParam("id") Long id, Model model,
                           @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        model.addAttribute("page", page);
        List<CommentDTO> commentDTOList = commentService.findAll(id);
        model.addAttribute("commentList", commentDTOList);

        return "boardPages/detail";
    }

    @GetMapping("/passwordCheck")
    public String passwordCheck(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        return "boardPages/passwordCheck";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        boardService.delete(id);
        return "redirect:/board/findAll";
    }

    @GetMapping("/update")
    public String updateForm(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("boardUpdate", boardDTO);
        return "boardPages/update";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO) {
        boardService.update(boardDTO);
        return "redirect:/board/detail?id=" + boardDTO.getId(); }

    @GetMapping("/saveFile")
    public String saveFileForm() {
        return "boardPages/saveFile";
    }

    @PostMapping("/saveFile")
    public String saveFile(@ModelAttribute BoardDTO boardDTO) throws IOException {
        boardService.saveFile(boardDTO);
        return "redirect:/board/findAll";
    }

    @GetMapping("/paging")
    public String paging(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                         Model model) {
        List<BoardDTO> boardList = boardService.pagingList(page);
        PageDTO paging = boardService.paging(page);
        model.addAttribute("boardList", boardList);
        model.addAttribute("paging", paging);
        return "boardPages/pagingList";
    }


    @GetMapping("/search")
    public String search(
                         @RequestParam(value = "searchType", required = false, defaultValue = "1") String searchType,
                         @RequestParam(value = "q") String q, Model model) {
        List<BoardDTO> newBoardDTOList = boardService.search(searchType, q);
        model.addAttribute("boardList", newBoardDTOList);
        model.addAttribute("searchValue", q);
        return "boardPages/list";

    }

//    $("#comment-write-btn").click(function (){
//        //댓글, 작성자, 내용을 가져오기
//        //ajax 문법을 활용하여 /comment/save 주소로 post 방식으로 작성자, 내용, 글번호 이렇게
//        // 세개의 값을 보내는 코드를 작성!
//        // ㅈㄴ어렵네;; ㄹㅇ;
//            const id =  ${board.id}
//            const commentWriter = document.getElementById("commentWriter");
//            const commentContents = document.getElementById("commentContents");
//        $.ajax({
//                type: "post", // http request method
//                url: "board/comment/save", // 요청주소(컨트롤러 주소값)
//                data: {"id": id,"commentWriter": commentWriter,"commentContents": commentContents}, // 전송하는 파라미터
//        dataType: "json", // 리턴받을 데이터 형식
//            })




}












