package com.its.board.controller;

import com.its.board.dto.CommentDTO;
import com.its.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    @PostMapping("/save")
    public @ResponseBody List<CommentDTO> save(@ModelAttribute CommentDTO commentDTO, Model model) {
        /**
         * 1.ajax 에서 받아온 새로운 댓글 내용을 DB에 저장
         * 2. DB에서 해당 글에 대한 댓글 목록을 가져와서 리턴
         * */

        commentService.save(commentDTO);


        List<CommentDTO> newCommentDTOList = commentService.findAll(commentDTO.getBoardId());

        model.addAttribute("commentList",newCommentDTOList);

        return newCommentDTOList;
    }
}
