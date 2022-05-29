package com.its.board.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentDTO {
private Long id;
private String commentWriter;
private String commentContents;
private Long boardId;
private Timestamp commentCreatedDate;
}
