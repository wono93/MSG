package com.kh.msg.board.model.dao;

import java.util.List;

import com.kh.msg.board.model.vo.Attachment;
import com.kh.msg.board.model.vo.Board;
import com.kh.msg.board.model.vo.Comment;
import com.kh.msg.board.model.vo.PagingVo;

public interface BoardDAO {

	List<Board> selectBoardList();

	int insertAttachment(Attachment attach);

	int insertBoard(Board board);

	Board selectOne(int boardNo);

	int boardUpdate(Board board);

	int deleteComment(Comment comment);
	
	int deleteCommentBoard(Comment comment);

	int deleteAttachment(Attachment attachment);

	int deleteBoard(Board board);

	int insertComment(Comment comment);

	int attachmentUpdate(Attachment attachment);

	int cntUp(Board board);

	int countBoard();

	Object selectBoard(PagingVo vo);
	
}
