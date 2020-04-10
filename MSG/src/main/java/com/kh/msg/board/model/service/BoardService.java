package com.kh.msg.board.model.service;

import java.util.List;

import com.kh.msg.board.model.vo.Attachment;
import com.kh.msg.board.model.vo.Board;
import com.kh.msg.board.model.vo.BoardRead;
import com.kh.msg.board.model.vo.BoardScrap;
import com.kh.msg.board.model.vo.Comment;
import com.kh.msg.board.model.vo.BoardPagingVo;
import com.kh.msg.member.model.vo.Member;

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

	Object selectBoard(BoardPagingVo vo);

	BoardScrap selectScrap(int boardNo);

	int deleteScrap(BoardScrap boardScrap);

	int getBoardScrap(BoardScrap voScrap);

	int updateBoard(Board board, List<Attachment> attachList);

	int attachUpdate(Attachment attachment);

	Member selectMember(int empNo);

	List<Member> selectMemberList();

	List<Attachment> selectAttachList();

	int countMyBoard(Board board);

	Object selectMyBoard(BoardPagingVo vo);

	int cntUp(Board board);

	List<Comment> selectComment(int boardNo);

	int insertRead(BoardRead boardRead);

	List<BoardRead> selectReadList();

	int countScrapBoard(BoardScrap boardScrap);

	Object selectScrapBoard(BoardPagingVo vo);

	int insertScrap(BoardScrap boardScrap);

	int countComment(Comment comment);

	List<Member> userLogin();

	
}
