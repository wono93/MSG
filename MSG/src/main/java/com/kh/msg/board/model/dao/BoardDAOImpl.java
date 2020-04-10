package com.kh.msg.board.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.board.model.vo.Attachment;
import com.kh.msg.board.model.vo.Board;
import com.kh.msg.board.model.vo.BoardRead;
import com.kh.msg.board.model.vo.BoardScrap;
import com.kh.msg.board.model.vo.Comment;
import com.kh.msg.board.model.vo.BoardPagingVo;
import com.kh.msg.member.model.vo.Member;

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
	public int countBoard(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.countBoard", board);
	}

	@Override
	public Object selectBoard(BoardPagingVo vo) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		return sqlSession.selectList("board.selectBoard", vo);
	}

	@Override
	public BoardScrap selectScrap(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.selectScrap", boardNo);
	}

	@Override
	public int deleteScrap(BoardScrap boardScrap) {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.deleteScrap", boardScrap);
	}

	@Override
	public int getBoardScrap(BoardScrap voScrap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.getBoardScrap", voScrap);
	}

	@Override
	public int attachUpdate(Attachment attachment) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.attachUpdate", attachment);
	}

	@Override
	public Member selectMember(int empNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.selectMember", empNo);
	}

	@Override
	public List<Member> selectMemberList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectMemberList");
	}

	@Override
	public List<Attachment> selectAttachList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectAttachList");
	}

	@Override
	public int countMyBoard(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.countMyBoard", board);
	}

	@Override
	public Object selectMyBoard(BoardPagingVo vo) {
		Map<String, String> map = new HashMap<String, String>();
		return sqlSession.selectList("board.selectMyBoard", vo);
	}

	@Override
	public int cntUp(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.cntUp", board);
	}

	@Override
	public List<Comment> selectComment(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectComment", boardNo);
	}

	@Override
	public int insertRead(BoardRead boardRead) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertRead", boardRead);
	}

	@Override
	public List<BoardRead> selectReadList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectReadList");
	}

	@Override
	public int countScrapBoard(BoardScrap boardScrap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.countScrapBoard", boardScrap);
	}

	@Override
	public Object selectScrapBoard(BoardPagingVo vo) {
		Map<String, String> map = new HashMap<String, String>();
		return sqlSession.selectList("board.selectScrapBoard", vo);
	}

	@Override
	public int insertScrap(BoardScrap boardScrap) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertScrap", boardScrap);
	}

	@Override
	public int countComment(Comment comment) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.countComment", comment);
	}

	@Override
	public List<Member> userLogin() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.userLogin");
	}

}