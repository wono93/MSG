package com.kh.msg.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.board.model.dao.BoardDAO;
import com.kh.msg.board.model.vo.Attachment;
import com.kh.msg.board.model.vo.Board;
import com.kh.msg.board.model.vo.Comment;
import com.kh.msg.board.model.vo.PagingVo;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<Board> selectBoardList() {
		// TODO Auto-generated method stub
		return boardDAO.selectBoardList();
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
	public int countBoard() {
		// TODO Auto-generated method stub
		return boardDAO.countBoard();
	}

	@Override
	public Object selectBoard(PagingVo vo) {
		return boardDAO.selectBoard(vo);
	}


	

}
