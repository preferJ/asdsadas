package com.its.board.service;

import com.its.board.dto.BoardDTO;
import com.its.board.dto.PageDTO;
import com.its.board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;


    public boolean save(BoardDTO boardDTO) {
        int result = boardRepository.save(boardDTO);
        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }

    public List<BoardDTO> findAll() {
        return boardRepository.findAll();
    }

    public BoardDTO findById(Long id) {
        boardRepository.updateHits(id);
        return boardRepository.findById(id);
    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }

    public void update(BoardDTO boardDTO) {
        boardRepository.update(boardDTO);
    }

    public void saveFile(BoardDTO boardDTO) throws IOException {


        MultipartFile boardFile = boardDTO.getBoardFile();
        String boardFileName = boardFile.getOriginalFilename(); //
        boardFileName = System.currentTimeMillis() + "-" + boardFileName;
        boardDTO.setBoardFileName(boardFileName);
        String savePath = "C:\\spring_img\\" + boardFileName;
        // 5.
        if (!boardFile.isEmpty()) {
            boardFile.transferTo(new File(savePath));
        }
        boardRepository.saveFile(boardDTO);
    }

    private static final int PAGE_LIMIT = 5;
    private static final int BLOCK_LIMIT = 3;

    public List<BoardDTO> pagingList(int page) {
        int pagingStart = (page - 1) * PAGE_LIMIT;
        Map<String, Integer> pagingParam = new HashMap<>();
        pagingParam.put("start", pagingStart);
        pagingParam.put("limit", PAGE_LIMIT);
        List<BoardDTO> pagingList = boardRepository.pagingList(pagingParam);
        return pagingList;
    }

    public PageDTO paging(int page) {
        int boardCount = boardRepository.boardCount();
        int maxPage = (int) (Math.ceil((double) boardCount / PAGE_LIMIT));
        int startPage = Math.max(1, (((int) (Math.ceil((double) page / BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1);
        int endPage = startPage + BLOCK_LIMIT - 1;
        if (endPage > maxPage)
            endPage = maxPage;
        PageDTO paging = new PageDTO();
        paging.setPage(page);
        paging.setStartPage(startPage);
        paging.setEndPage(endPage);
        paging.setMaxPage(maxPage);
        return paging;
    }

    public List<BoardDTO> search(String searchType, String q) {
        Map<String, String> searchParam = new HashMap<>();
        searchParam.put("type", searchType);
        searchParam.put("q", q);
        List<BoardDTO> newBoardDTOList = boardRepository.search(searchParam);
        return newBoardDTOList;
    }

    public List<BoardDTO> findByMemberId(String memberId) {
        return boardRepository.findByMemberId(memberId);
    }
}
















