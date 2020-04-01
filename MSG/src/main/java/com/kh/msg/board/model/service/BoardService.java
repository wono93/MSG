package com.kh.msg.board.model.service;

import java.util.List;

import com.kh.msg.board.model.vo.Attachment;
import com.kh.msg.board.model.vo.Board;
import com.kh.msg.board.model.vo.BoardScrap;
import com.kh.msg.board.model.vo.Comment;
import com.kh.msg.board.model.vo.PagingVo;

public interface BoardService {

	List<Board> selectBoardList();

	int insertBoard(Board board, List<Attachment> attachList);

	Board selectOne(int boardNo);

	int boardUpdate(Board board);
	
	int deleteComment(Comment comment);
	
	int deleteCommentBoard(Comment comment);
	
	int deleteAttachment(Attachment attachment);
	
	int deleteBoard(Board board);

	int insertComment(Comment comment, int boardNo);

	int attachmentUpdate(Attachment attachment);

	int countBoard(Board board);

	Object selectBoard(PagingVo vo);

	int insertScrap(BoardScrap voScrap);

	BoardScrap selectScrap(int boardNo);

	int deleteScrap(BoardScrap voScrap);

	int getBoardScrap(BoardScrap voScrap);

	int updateBoard(Board board, List<Attachment> attachList);

	int attachUpdate(Attachment attachment);

	
}
