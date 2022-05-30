package com.its.board.service;

import com.its.board.dto.CommentDTO;
import com.its.board.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public void save(CommentDTO commentDTO) {
        commentRepository.save(commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId) {
        return commentRepository.findAll(boardId);
    }
    public List<CommentDTO> findAll() {
        return commentRepository.findAll();
    }


    public void delete(long boardId, long id) {
        Map<String, Long> deleteCommentParam = new HashMap<>();

        commentRepository.delete(deleteCommentParam);
    }
}
