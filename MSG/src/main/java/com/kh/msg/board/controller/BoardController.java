package com.kh.msg.board.controller;


import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.msg.board.model.service.BoardService;
import com.kh.msg.board.model.vo.Attachment;
import com.kh.msg.board.model.vo.Board;
import com.kh.msg.board.model.vo.Comment;
import com.kh.msg.board.model.vo.PagingVo;
import com.kh.msg.common.util.Utils;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@GetMapping("/list.do")
	public ModelAndView selectBoardList(ModelAndView modelAndView){
		log.debug("게시판 목록페이지!");
		ModelAndView mav = new ModelAndView();
		
		//업무로직처리
		//1. 현재페이지 컨텐츠 구하기
		List<Board> list = boardService.selectBoardList();
		log.debug("list="+list);
		
		
		mav.addObject("list",list);
		mav.setViewName("board/boardList");
		return mav;
	}
	
	@GetMapping("/view.do")
	public String view(@RequestParam("boardNo") int boardNo, Board board,
			 Model model) {

		board = boardService.selectOne(boardNo);
		
		//조회수 증가
		int result = boardService.cntUp(board, boardNo);
		log.debug("result================"+result);
		log.debug("board================"+board);
		
    	model.addAttribute("board", board);
    	return "board/boardView";
	}
	
	@PostMapping("/deleteComment.do")
	public String commentDelete(@RequestParam("boardNo") int boardNo,
			Comment comment, RedirectAttributes redirectAttributes) {
		
    	int result = boardService.deleteComment(comment);
    	
    	log.debug("comment delete="+comment);

		return "redirect:/board/view.do?boardNo="+boardNo;
	}
	
	
	@PostMapping("/insertComment.do")
	public String commentInsert(@RequestParam("boardNo") int boardNo, Comment comment,
		Model model, RedirectAttributes redirectAttributes) {
		
    	int result = boardService.insertComment(comment, boardNo); 
		
		return "redirect:/board/view.do?boardNo="+boardNo;
	}
	
	@PostMapping("/deleteBoard.do")
	public String deleteBoard(Attachment attachment,Comment comment,
			Board board, RedirectAttributes redirectAttributes) {
		int result1 = boardService.deleteAttachment(attachment);
		int result2 = boardService.deleteCommentBoard(comment);
    	int result3 = boardService.deleteBoard(board);
    	
    	return "redirect:/board/list.do";
	}
	
	@GetMapping("/write.do")
	public String write() {
		return "board/boardWrite";
	}
	
	@PostMapping("/write.do")
    public String insert(Board board, 
    					 @RequestParam(value="upFile", required=false) 
    					 MultipartFile[] upFiles,
    					 HttpServletRequest request,
    					 RedirectAttributes redirectAttributes) {
	
    	log.debug("board={}",board);
    	
    	try {
    		
	    	List<Attachment> attachList = new ArrayList<>();
	    	
	    	for(MultipartFile f : upFiles) {
	    		
	    		//비어있는 MultipartFile객체가 전달된 경우(파일하나만 업로드)
	    		if(f.isEmpty()) continue;
	    		
	//    		log.debug("filename={}",f.getOriginalFilename());
	//    		log.debug("size={}",f.getSize());
	    		
	    		//파일명 재생성 renamedFileName으로 저장하기
	    		String file = f.getOriginalFilename();
	    		String refile = Utils.getRefile(file);
	    		
	    		//파일이동
	    		String saveDirectory
	    			= request.getServletContext()
	    					 .getRealPath("/resources/upload/board");
	    		
	    		try {
					f.transferTo(new File(saveDirectory, refile));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
	    		
	    		//실제 파일데이터 originalFileName, renamedFileName을 db에 저장
	    		//Attachment객체
	    		Attachment attach = new Attachment();
	    		attach.setFile(file);
	    		attach.setRefile(refile);
	    		
	    		attachList.add(attach);
	    	}
	    	
	    	log.debug("attachList={}",attachList);
	    	
	    	int result = boardService.insertBoard(board, attachList);
	    	
	    	redirectAttributes.addFlashAttribute("msg", result>0?"등록성공!":"등록실패!");
	    	
    	} catch(Exception e) {
    		log.error("게시판 등록 오류! ", e);
    	}
    	
    	return "redirect:/board/list.do";
    }
    
    /**
     * /board/view.do
     * 
     * => board/view
     * 
     * (ViewNameTranslator)
     * - 앞/뒤 슬래쉬 제거
     * - 파일확장자제거(.jsp는 예외)
     *  
     */
	/**
     * Resource 
     * - 웹상의 자원(파일)
     * - 서버상의 자원(파일)
     * 
     * @param oName
     * @param rName
     * @return
     */
    @GetMapping("/fileDownload.do")
    @ResponseBody
    public Resource fileDownload(@RequestParam("oName") String oName,
    							 @RequestParam("rName") String rName,
    							 HttpServletResponse response) {
    	//파일의 실제 저장경로(절대경로)
    	String saveDirectory
    		= servletContext.getRealPath("/resources/upload/board");
    	File downFile = new File(saveDirectory, rName);
    	Resource resource = resourceLoader.getResource("file:"+downFile);
    	
    	//응답헤더작성
    	String downFileName = null;
    	try {
			downFileName = new String(oName.getBytes("utf-8"),"ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
    	response.setContentType("application/octet-stream; charset=utf-8");
    	response.addHeader("Content-Disposition", 
    					   "attachment; filename=\""+downFileName+"\"");
    	
    	return resource;
    }
    
    @GetMapping("/update.do")
    public String update(@RequestParam("boardNo") int boardNo, 
			 Model model) {
    	Board board = boardService.selectOne(boardNo);
    	
    	model.addAttribute("board", board);
    	
		return "board/boardUpdate";
    }
    
    @PostMapping("/update.do")
	public String update(@RequestParam("boardNo") int boardNo,
			Board board, Attachment attachment,
			RedirectAttributes redirectAttributes) {
	int result1 = boardService.boardUpdate(board);
	log.debug("boardupdate===="+board);
	
	redirectAttributes.addFlashAttribute("msg", result1>0?"수정 성공!":"수정 실패!");
	
	return "redirect:/board/view.do?boardNo="+boardNo;
	
    }
    
    @GetMapping("boardList")
    public String boardList(PagingVo vo, Model model
    		, @RequestParam(value="nowPage", required=false)String nowPage
    		, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
    	
    	int total = boardService.countBoard();
    	if (nowPage == null && cntPerPage == null) {
    		nowPage = "1";
    		cntPerPage = "15";
    	} else if (nowPage == null) {
    		nowPage = "1";
    	} else if (cntPerPage == null) { 
    		cntPerPage = "15";
    	}
    	vo = new PagingVo(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
    	model.addAttribute("paging", vo);
    	model.addAttribute("viewAll", boardService.selectBoard(vo));
    	return "board/boardPaging";
    }
    
    
}