package com.its.board.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;

@Data
public class BoardDTO {
    private Long id;
    private String boardWriter;
    private String boardPassword;
    private String boardTitle;
    private String boardContents;
    private Timestamp boardCreatedDate;
    private int boardHits;
    private MultipartFile boardFile; // saveFile.jsp 에서 컨트롤러로 넘어올 때 파일을 담아오는 용도
    private String boardFileName; // 상세조회 등을 할 때 파일 이름을 담을 용도
}
