package com.kh.msg.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.board.model.dao.BoardDAO;
import com.kh.msg.board.model.vo.Attachment;
import com.kh.msg.board.model.vo.Board;
import com.kh.msg.board.model.vo.BoardPagingVo;
import com.kh.msg.board.model.vo.BoardRead;
import com.kh.msg.board.model.vo.BoardScrap;
import com.kh.msg.board.model.vo.Comment;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<Board> selectBoardList(int empNo) {
		// TODO Auto-generated method stub
		return boardDAO.selectBoardList(empNo);
	}
	
	@Override
	public Board selectOne(int boardNo) {
		// TODO Auto-generated method stub
		return boardDAO.selectOne(boardNo);
	}


	@Override
	public int insertBoard(Board board, List<Attachment> attachList) {
		// TODO Auto-generated method stub
		int result = 0;
		result = boardDAO.insertBoard(board);
		
		if(result == 0)
			System.out.println("게시글 등록오류");
			
		for(Attachment attach : attachList) {
			attach.setBrdNo(board.getNo());
			result = boardDAO.insertAttachment(attach);
			
			if(result == 0)
				System.out.println("첨부파일 등록 오류");
		}
		return result;		
	}
	@Override
	public int boardUpdate(Board board) {
		// TODO Auto-generated method stub
		return boardDAO.boardUpdate(board);
	}

	@Override
	public int deleteComment(Comment comment) {
		// TODO Auto-generated method stub
		return boardDAO.deleteComment(comment);
	}
	
	@Override
	public int deleteCommentBoard(Comment comment) {
		// TODO Auto-generated method stub
		return boardDAO.deleteCommentBoard(comment);
	}
	
	@Override
	public int deleteAttachment(Attachment attachment) {
		// TODO Auto-generated method stub
		return boardDAO.deleteAttachment(attachment);
	}

	@Override
	public int deleteBoard(Board board) {
		// TODO Auto-generated method stub
		return boardDAO.deleteBoard(board);
	}

	@Override
	public int insertComment(Comment comment, int boardNo) {
		// TODO Auto-generated method stub
		comment.setBrdNo(boardNo);
		return boardDAO.insertComment(comment);
	}

	@Override
	public int attachmentUpdate(Attachment attachment) {
		// TODO Auto-generated method stub
		return boardDAO.attachmentUpdate(attachment);
	}

	
	@Override
	public int countBoard(Board board) {
		// TODO Auto-generated method stub
		return boardDAO.countBoard(board);
	}

	@Override
	public Object selectBoard(BoardPagingVo vo) {
		return boardDAO.selectBoard(vo);
	}

	

	@Override
	public int deleteScrap(BoardScrap boardScrap) {
		// TODO Auto-generated method stub
		return boardDAO.deleteScrap(boardScrap);
	}

	@Override
	public int getBoardScrap(BoardScrap voScrap) {
		// TODO Auto-generated method stub
		return boardDAO.getBoardScrap(voScrap);
	}

	@Override
	public int updateBoard(Board board, List<Attachment> attachList) {
		// TODO Auto-generated method stub
		 //게시판 update랑 파일첨부 insert로 나눠짐
		int result = 0;
		result = boardDAO.boardUpdate(board);
		
		if(result == 0)
			System.out.println("게시글 수정오류");
			
		for(Attachment attach : attachList) {
			attach.setBrdNo(board.getNo());
			result = boardDAO.insertAttachment(attach);
			
			if(result == 0)
				System.out.println("첨부파일 등록 오류");
		}
		return result;	
	}

	@Override
	public int attachUpdate(Attachment attachment) {
		// TODO Auto-generated method stub
		return boardDAO.attachUpdate(attachment);
	}

	@Override
	public OrgChart selectMember(int empNo) {
		// TODO Auto-generated method stub
		return boardDAO.selectMember(empNo);
	}

	@Override
	public List<OrgChart> selectMemberList() {
		// TODO Auto-generated method stub
		return boardDAO.selectMemberList();
	}

	@Override
	public List<Attachment> selectAttachList() {
		// TODO Auto-generated method stub
		return boardDAO.selectAttachList();
	}

	@Override
	public int countMyBoard(Board board) {
		// TODO Auto-generated method stub
		return boardDAO.countMyBoard(board);
	}

	@Override
	public Object selectMyBoard(BoardPagingVo vo) {
		// TODO Auto-generated method stub
		return boardDAO.selectMyBoard(vo);
	}

	@Override
	public int cntUp(Board board) {
		// TODO Auto-generated method stub
		return boardDAO.cntUp(board);
	}

	@Override
	public List<Comment> selectComment(int boardNo) {
		// TODO Auto-generated method stub
		return boardDAO.selectComment(boardNo);
	}

	@Override
	public int insertRead(BoardRead boardRead) {
		// TODO Auto-generated method stub
		return boardDAO.insertRead(boardRead);
	}

	@Override
	public List<BoardRead> selectReadList() {
		// TODO Auto-generated method stub
		return boardDAO.selectReadList();
	}

	@Override
	public int countScrapBoard(BoardScrap boardScrap) {
		// TODO Auto-generated method stub
		return boardDAO.countScrapBoard(boardScrap);
	}

	@Override
	public Object selectScrapBoard(BoardPagingVo vo) {
		// TODO Auto-generated method stub
		return boardDAO.selectScrapBoard(vo);
	}

	@Override
	public int insertScrap(BoardScrap boardScrap) {
		// TODO Auto-generated method stub
		return boardDAO.insertScrap(boardScrap);
	}

	@Override
	public int countComment(Comment comment) {
		// TODO Auto-generated method stub
		return boardDAO.countComment(comment);
	}

	@Override
	public List<OrgChart> userLogin() {
		// TODO Auto-generated method stub
		return boardDAO.userLogin();
	}

	@Override
	public int selectScrap(BoardScrap boardScrap, int memberEmpno, int boardNo) {
		boardScrap.setEmpNo(memberEmpno);
		boardScrap.setNo(boardNo);
		return boardDAO.selectScrap(boardScrap);
	}

	

	

	
}
