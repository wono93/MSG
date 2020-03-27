package com.kh.msg.board.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.board.model.vo.Attachment;
import com.kh.msg.board.model.vo.Board;
import com.kh.msg.board.model.vo.Comment;
import com.kh.msg.board.model.vo.PagingVo;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Board> selectBoardList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectBoardList");
	}

	@Override
	public int insertAttachment(Attachment attach) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertAttachment", attach);
	}

	@Override
	public int insertBoard(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertBoard", board);
	}

	@Override
	public Board selectOne(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.selectOne",boardNo);
	}

	@Override
	public int boardUpdate(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.boardUpdate",board);
	}

	@Override
	public int deleteComment(Comment comment) {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.deleteComment",comment);
	}
	
	@Override
	public int deleteCommentBoard(Comment comment) {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.deleteCommentBoard",comment);
	}

	@Override
	public int deleteAttachment(Attachment attachment) {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.deleteAttachment",attachment);
	}

	@Override
	public int deleteBoard(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.deleteBoard",board);
	}

	@Override
	public int insertComment(Comment comment) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertComment",comment);
	}

	@Override
	public int attachmentUpdate(Attachment attachment) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.attachmentUpdate", attachment);
	}

	@Override
	public int cntUp(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.cntUp", board);
	}

	@Override
	public int countBoard() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.countBoard");
	}

	@Override
	public Object selectBoard(PagingVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.selectBoard", vo);
	}
}