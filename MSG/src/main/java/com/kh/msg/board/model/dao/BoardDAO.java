package com.kh.msg.board.model.dao;

import java.util.List;

import com.kh.msg.board.model.vo.Attachment;
import com.kh.msg.board.model.vo.Board;
import com.kh.msg.board.model.vo.BoardScrap;
import com.kh.msg.board.model.vo.Comment;
import com.kh.msg.board.model.vo.PagingVo;
import com.kh.msg.member.model.vo.Member;

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

	int countBoard(Board board);

	Object selectBoard(PagingVo vo);

	int insertScrap(BoardScrap boardScrap);

	BoardScrap selectScrap(int boardNo);

	int deleteScrap(BoardScrap boardScrap);

	int getBoardScrap(BoardScrap voScrap);

	int attachUpdate(Attachment attachment);

	Member selectMember(int empNo);

	List<Member> selectMemberList();

	List<Attachment> selectAttachList();

	int countMyBoard(Board board);

	Object selectMyBoard(PagingVo vo);

	int cntUp(Board board);

	List<Comment> selectComment(int boardNo);

}
