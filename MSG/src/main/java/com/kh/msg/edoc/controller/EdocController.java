package com.kh.msg.edoc.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.converter.pdf.PdfConverter;
import org.apache.poi.xwpf.converter.pdf.PdfOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.msg.common.util.Utils;
import com.kh.msg.edoc.model.service.EdocService;
import com.kh.msg.edoc.model.vo.Edoc;
import com.kh.msg.edoc.model.vo.EdocAtt;
import com.kh.msg.edoc.model.vo.EdocFlow;
import com.kh.msg.edoc.model.vo.EdocFlowEx;
import com.kh.msg.edoc.model.vo.EdocLeaveLtt;
import com.kh.msg.edoc.model.vo.EdocSrch;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@Slf4j
@RequestMapping("/edoc")
public class EdocController {

	@Autowired
	EdocService edocService;

	@GetMapping("/list.do")
	public ModelAndView list(@RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "srchWord", defaultValue = "") String srchWord,
			@RequestParam(value = "srchType", defaultValue = "all") String srchType,
//			@RequestParam(value = "arrayDocuCheck", defaultValue = "myDocu,reqDocu,coopDocu,compDocu,refDocu") String[] arrayDocuCheck,
			@RequestParam(value = "arrayDocuCheck", defaultValue = "myDocu") String[] arrayDocuCheck,
			HttpSession session) {
		log.debug("=========내 전자문서 페이지=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;

		OrgChart m = (OrgChart) session.getAttribute("memberLoggedIn");// 로그인 객체 호출

		// 일단 초기값은 모든 종류의 문서를 가져오는 것으로 가정 => 변경 : 초기값은 myDocu / 파라미터 참조
		String myDocu = "y";
		String reqDocu = "y";
		String coopDocu = "y";
		String compDocu = "y";
		String refDocu = "y";

		if (!Arrays.stream(arrayDocuCheck).anyMatch("myDocu"::equals))
			myDocu = "n";
		if (!Arrays.stream(arrayDocuCheck).anyMatch("reqDocu"::equals))
			reqDocu = "n";
		if (!Arrays.stream(arrayDocuCheck).anyMatch("coopDocu"::equals))
			coopDocu = "n";
		if (!Arrays.stream(arrayDocuCheck).anyMatch("compDocu"::equals))
			compDocu = "n";
		if (!Arrays.stream(arrayDocuCheck).anyMatch("refDocu"::equals))
			refDocu = "n";

		// docuCheckMap : 페이지 리다이렉트시 이전에 선택한 검색 조건을 유지 하기 위해 사용
		Map<String, String> docuCheckMap = new HashMap<String, String>();
		docuCheckMap.put("myDocu", myDocu);
		docuCheckMap.put("reqDocu", reqDocu);
		docuCheckMap.put("coopDocu", coopDocu);
		docuCheckMap.put("compDocu", compDocu);
		docuCheckMap.put("refDocu", refDocu);

		//
		Map<String, String> map = new HashMap<>();
		map.put("srchWord", srchWord);
		map.put("srchType", srchType);
		map.put("empNo", m.getEmpNo() + "");// member.getEmpNo()+""
		map.put("myDocu", myDocu);
		map.put("reqDocu", reqDocu);
		map.put("coopDocu", coopDocu);
		map.put("compDocu", compDocu);
		map.put("refDocu", refDocu);

		List<EdocSrch> list = edocService.selectMyList(cPage, numPerPage, map);

		String docuType = "";
		if(myDocu.equals("y")) docuType = "myDocu";
		if(reqDocu.equals("y")) docuType = "reqDocu";
		if(coopDocu.equals("y")) docuType = "coopDocu";
		if(compDocu.equals("y")) docuType = "compDocu";
		if(refDocu.equals("y")) docuType = "refDocu";
		
		
		log.debug("list.toString()={}", list.toString());
		int totalContents = edocService.selectMyEdocTotalContents(map);

		mav.addObject("myEdocList", list);

//		여기서부터 페이징
		final int totalPage = (int) (Math.ceil((double) totalContents / numPerPage));
		final int pageBarSize = 5;
		final int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		final int pageEnd = (pageStart + pageBarSize) - 1;
		int pageNo = pageStart;

		String pageBar = "";
		if (pageNo == 1) {
			pageBar += "<a href=\"#\" class=\"arrow\">&laquo;</a>";
		} else {
			pageBar += "<a href='/msg/edoc/list.do?cPage=" + (pageNo - 1) + "&srchWord=" + srchWord + "&srchType="
					+ srchType +"&arrayDocuCheck="+docuType+"'>&laquo;</a>";
		}

		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				pageBar += "<a class='active'>" + pageNo + "</a>";
			} else {
				pageBar += "<a href='/msg/edoc/list.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType="
						+ srchType+"&arrayDocuCheck="+docuType+"'>" + pageNo + "</a>";
			}
			pageNo++;
		}
		;
		if (pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		} else {
			pageBar += "<a href='/msg/edoc/list.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType=" + srchType
					+"&arrayDocuCheck="+docuType+"'>&raquo;</a>";
		}
		;

		mav.addObject("pageBar", pageBar);
		mav.addObject("cPage", cPage);
		mav.addObject("docuCheckMap", docuCheckMap);
		mav.addObject("srchWord", srchWord);
		mav.addObject("srchType", srchType);

		mav.setViewName("edoc/edocList");

		return mav;
	}

	@GetMapping("/srch.do")
	public ModelAndView srch(@RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "srchWord", defaultValue = "")String srchWord,
			@RequestParam(value = "srchType", defaultValue = "all") String srchType) {
		log.debug("=========전자문서 검색 페이지=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;

		log.debug("srchWord@srch.EdocController{}", srchWord);
		log.debug("srchType@srch.EdocController{}", srchType);

		List<EdocSrch> list = edocService.selectList(cPage, numPerPage, srchWord, srchType);

		int totalContents = edocService.selectEdocTotalContents(srchWord, srchType);

		mav.addObject("srchList", list);
		mav.addObject("totalContents", totalContents);

//		여기서부터 페이징
		final int totalPage = (int) (Math.ceil((double) totalContents / numPerPage));
		final int pageBarSize = 5;
		final int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		final int pageEnd = (pageStart + pageBarSize) - 1;
		int pageNo = pageStart;

		String pageBar = "";
		if (pageNo == 1) {
			pageBar += "<a href=\"#\" class=\"arrow\">&laquo;</a>";
		} else {
			pageBar += "<a href='/msg/edoc/srch.do?cPage=" + (pageNo - 1) + "&srchWord=" + srchWord + "&srchType="
					+ srchType + "'>&laquo;</a>";
		}

		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				pageBar += "<a class='active'>" + pageNo + "</a>";
			} else {
				pageBar += "<a href='/msg/edoc/srch.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType="
						+ srchType + "'>" + pageNo + "</a>";
			}
			pageNo++;
		}
		;
		if (pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		} else {
			pageBar += "<a href='/msg/edoc/srch.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType=" + srchType
					+ "'>&raquo;</a>";
		}
		;

		mav.addObject("pageBar", pageBar);
		mav.addObject("cPage", cPage);
		mav.addObject("srchWord", srchWord);
		mav.addObject("srchType", srchType);
		
		mav.setViewName("edoc/edocSrch");
		return mav;
	}

	@GetMapping("/confirm.do")
	public String confirm() {
		return "edoc/edocConfirm";
	}

	@GetMapping("/read.do")
	public String read() {
		return "edoc/edocRead";
	}

	@GetMapping("/write.do")
	public String write(HttpSession session) {
		Member m = (Member) session.getAttribute("memberLoggedIn");
		log.debug("------------------------------------------------------------------{}", m);
		return "edoc/edocWrite";
	}

	@ResponseBody
	@PostMapping("/write.do")
	public String edocWrite(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws Exception, IOException {
		
		// 새로운 EdocId 받아오기
		String edocId = edocService.newEdocId();
		
		
		// 파일 첨부 파트
		List<EdocAtt> edocAttList = new ArrayList<>();
		log.debug(request.getFiles("files").toString());
		
		List<MultipartFile> fileList = new ArrayList<MultipartFile>(); // input file 에 아무것도 없을 경우 (파일을 업로드 하지 않았을 때 처리)
//		if (request.getFiles("files").get(0).getSize() != 0) {
		if (!request.getFiles("files").isEmpty()) {
			fileList = request.getFiles("files");
		}
		
		String path = request.getServletContext().getRealPath("/resources/upload/edoc");
		File fileDir = new File(path);
		if (!fileDir.exists()) {
			fileDir.mkdirs();
		}
		for (MultipartFile mf : fileList) {
			String originFilename = mf.getOriginalFilename(); // 원본 파일 명
			String renamedFilename = Utils.getRefile(originFilename);
			mf.transferTo(new File(path, renamedFilename));
			EdocAtt edocAtt = new EdocAtt();
			edocAtt.setOriginFilename(originFilename);
			edocAtt.setRenamedFilename(renamedFilename);
			edocAtt.setEdocId(edocId);
			edocAttList.add(edocAtt);
		}

		
		JSONArray jsonArr = new JSONArray();

		for (int i = 0; i < edocAttList.size(); i++) {
			JSONObject sObject = new JSONObject();
			sObject.put("originFilename", edocAttList.get(i).getOriginFilename());
			sObject.put("renamedFilename", edocAttList.get(i).getRenamedFilename());
			
			jsonArr.add(sObject);
			
		}



		List<EdocFlow> edocFlowList = new ArrayList<>();
		EdocLeaveLtt edocLeaveLtt = new EdocLeaveLtt();
		
		
//		log.debug("jsonArray@EdocController={}", map.);
		
		String secuCd = request.getParameter("secuCd");
        String prsvCd = request.getParameter("prsvCd");
        String empNo = request.getParameter("empNo");
        String edocTitle = request.getParameter("edocTitle");
        String vctnCd = request.getParameter("vctnCd");
        String startDt = request.getParameter("startDt");
        String endDt = request.getParameter("endDt");
        String leaveAmt = request.getParameter("leaveAmt");
        String leavePurpose = request.getParameter("leavePurpose");
        String leaveContact = request.getParameter("leaveContact");
        String surEmpNo = request.getParameter("surEmpNo");
        String typeCd = request.getParameter("typeCd");
        String flowLineJson = request.getParameter("flowLine");
        String coopLineJson = request.getParameter("coopLine");
        String flowCd = request.getParameter("flowCd");
        
        

     // 결재선 등록 파트
        String[] flowLine = flowLineJson.split(",");
        for(int i = 0; i < flowLine.length/4; i++){
        	EdocFlow ef = new EdocFlow();
        	ef.setEdocId(edocId);
            // F1 : 결재, F2 : 전결
            if (!flowCd.equals("null")) {
            	if ((Integer.parseInt(flowCd) - 1) == i)
            		ef.setFlowCd("F2");
            } else
            	ef.setFlowCd("F1");
            ef.setFlowEmpNo(flowLine[4*i]);
            ef.setFlowOrd(i + 1);
            edocFlowList.add(ef);
        }
        
        // 협조선 등록 파트
        String[] coopLine = coopLineJson.split(",");
        for(int i = 0; i < coopLine.length/4; i++){
        	EdocFlow ef = new EdocFlow();
        	ef.setEdocId(edocId);
            // F3 : 협조
        	ef.setFlowCd("F3");
            ef.setFlowEmpNo(coopLine[4*i]);
            ef.setFlowOrd(i + 1);
            edocFlowList.add(ef);
        }
        
		// 전자문서 등록 파트(휴가신청서)
		edocLeaveLtt.setEdocId(edocId);
		edocLeaveLtt.setSecuCd(secuCd);
		edocLeaveLtt.setPrsvCd(prsvCd);
		edocLeaveLtt.setEmpNo(Integer.parseInt(empNo));
		edocLeaveLtt.setEdocTitle(edocTitle);
		edocLeaveLtt.setVctnCd(vctnCd);
		edocLeaveLtt.setStartDt(startDt);
		edocLeaveLtt.setEndDt(endDt);
		edocLeaveLtt.setLeaveAmt(Integer.parseInt(leaveAmt));
		edocLeaveLtt.setLeavePurpose(leavePurpose);
		edocLeaveLtt.setLeaveContact(leaveContact);
		if (surEmpNo != null) {
			edocLeaveLtt.setSurEmpNo(surEmpNo);
		}
		edocLeaveLtt.setTypeCd(typeCd);

		
		int result = edocService.edocWrite(edocLeaveLtt, edocAttList, edocFlowList);
		log.debug("write.do@EdocController={}", result);
		
		String edocTitleFromPage = edocLeaveLtt.getEdocTitle();
		edocTitleFromPage = URLEncoder.encode(edocTitleFromPage, "UTF-8");
		
		return "/edoc/edocSrchView.do?edocId="+edocLeaveLtt.getEdocId()+"&edocTitleFromPage="+edocTitleFromPage+"";
		
	}
	

	@GetMapping("/jstree.do")
	public void jstree(HttpServletResponse response) {

		try {
			List<Jstree> list = edocService.selectJstree();
			log.debug("list@EdocController" + list.toString());

			JSONArray jsonArr = new JSONArray();

			for (int i = 0; i < list.size(); i++) {
				JSONObject sObject = new JSONObject();
				sObject.put("id", list.get(i).getId());
				if ((list.get(i).getParent()) == null) {
					sObject.put("parent", "#");
				} else {
					sObject.put("parent", list.get(i).getParent());
				}
				sObject.put("text", list.get(i).getText());
				sObject.put("icon", list.get(i).getIcon());
				jsonArr.add(sObject);
			}

			response.setCharacterEncoding("UTF-8");
			PrintWriter out;
			out = response.getWriter();
			out.write(jsonArr.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@GetMapping("/jstreeMem.do")
	public void jstreeMem(HttpServletRequest request, HttpServletResponse response) throws IOException{
		if (request.getParameter("id").charAt(0) == 'D') {
			JSONObject sObject = new JSONObject();
			sObject.put("empNo", "fail");
			sObject.put("dept", "fail");
			sObject.put("job", "fail");
			sObject.put("name", "fail");

			response.setCharacterEncoding("UTF-8");
			PrintWriter out;
			out = response.getWriter();
			out.write(sObject.toString());
		} else {
			JstreeMem memOne = edocService.selectJstreeMem(request.getParameter("id"));
			log.debug("memOne@EdocController" + memOne.toString());
			JSONObject sObject = new JSONObject();
			sObject.put("empNo", memOne.getEmpNo());
			sObject.put("dept", memOne.getDeptName());
			sObject.put("job", memOne.getJobName());
			sObject.put("name", memOne.getEmpName());

			response.setCharacterEncoding("UTF-8");
			PrintWriter out;
			out = response.getWriter();
			out.write(sObject.toString());
		}
	}

	@RequestMapping(value = "/getHiddenAddr.do")
	public void getHiddenAddr(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("application/pdf");
		String url = "http://127.0.0.1:9090"+request.getContextPath()+"/resources/upload/edocPdf/"; // 앞에 주소가 반드시 필요하네 ㅡㅡ
//		String url = request.getServletContext().getRealPath("/resources/upload/edocPdf/"); // 주소는 불러오는데, 정작 파일을 못가져옴. 프로토콜 에러
		String attachId = request.getParameter("attachId"); // 일단 파일명은 jsp에서 받아옴. 여기서 attchId를 받아와서 파일명을 아예 숨기자.
		EdocAtt edocAtt = edocService.selectPdf(attachId);
		String filename = edocAtt.getRenamedFilename();
		
		URL fileUrl = new URL(url+filename);
		IOUtils.copy(fileUrl.openStream(), response.getOutputStream());
	}
	
	
	@ResponseBody
	@GetMapping("/edocSrchView.do")
	public ModelAndView edocSrchViewPost(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) throws InvalidFormatException, IOException {
		edocService.deleteEdocPdfSt(); // 보안을 위해 DB의 pdf 목록 초기화, update/delete 문에서 무한 로딩나면 기존에 commit이 되어 있는지 확인하자. 
		
		String edocId = request.getParameter("edocId"); // 파라미터로 넣을 edocId 가져오기
		List<EdocFlowEx> edocFlowExList = edocService.selectEdocFlowExList(edocId);
		EdocAtt edocAtt = createDocFromTemplate(request, edocId);

		String attachId = edocService.insertPdf(edocAtt);
		String edocTitleFromPage = request.getParameter("edocTitleFromPage");
		mav.addObject("attachId", attachId);
		mav.addObject("edocFlowExList", edocFlowExList);
		mav.addObject("edocTitleFromPage", edocTitleFromPage);
		mav.setViewName("edoc/edocSrchRead");
		return mav;
	}

	public EdocAtt createDocFromTemplate(HttpServletRequest request, String edocId) throws InvalidFormatException, IOException {		
		// Edoc에 배열이 두 개 들어있으므로, 배열 데이터는 따로 갖고 온다. 이쪽이 문서 작성할때도 편리.
		List<EdocFlow> edocFlowList = edocService.selectEdocFlowList(edocId); // 결재선은 jsp에서도 필요하므로 여기서 가져온다. 
		EdocLeaveLtt edocLeaveLtt = edocService.selectEdocLeaveLtt(edocId);
		Edoc edoc = edocLeaveLtt; // 공통부분은 Edoc으로 빼서 사용
		
		// 따로 가져온 결재선
		List<EdocFlow> FList = new ArrayList<EdocFlow>();
		for (int i = 0; i < edocFlowList.size(); i++) {
			if(edocFlowList.get(i).getFlowCd().equals("F1")||edocFlowList.get(i).getFlowCd().equals("F2")) {
				FList.add(edocFlowList.get(i));
			}
		}
		List<EdocFlow> CList = new ArrayList<EdocFlow>();
		for (int i = 0; i < edocFlowList.size(); i++) {
			if(edocFlowList.get(i).getFlowCd().equals("F3")) {
				CList.add(edocFlowList.get(i));
			}
		}
		
		// 따로 가져온 첨부파일
		List<EdocAtt> edocAttList= edocService.selectEdocAttList(edocId);
		String AttList = "";
		for(int i = 0; i < edocAttList.size(); i++) {
			if(edocAttList.get(i).getEdocPdfSt()==null)
			AttList += edocAttList.get(i).getOriginFilename()+"\r\n";
		}
		
		
		// doc 템플릿 열 때에 읽기 쓰기 권한 획득
		XWPFDocument doc = new XWPFDocument(OPCPackage.open(request.getServletContext().getRealPath("/resources/template/leaveTemplate.docx")));

		// doc 템플릿에 DB값 삽입
		for (XWPFParagraph p : doc.getParagraphs()) {
			List<XWPFRun> runs = p.getRuns();
			if (runs != null) {
				for (XWPFRun r : runs) {
					String text = r.getText(0);
					if (text != null && text.contains("tmpEdocTitle")) {
						text = text.replace("tmpEdocTitle", edocLeaveLtt.getEdocTitle());;
						r.setText(text, 0);
					}
				}
			}
		}
		for (XWPFTable tbl : doc.getTables()) {
			for (XWPFTableRow row : tbl.getRows()) {
				for (XWPFTableCell cell : row.getTableCells()) {
					for (XWPFParagraph p : cell.getParagraphs()) {
						for (XWPFRun r : p.getRuns()) {
							String text = r.getText(0);
							// 문서정보(공통 edoc)
							if (text != null && text.contains("tmpEdocTitle")) {
								text = text.replace("tmpEdocTitle", edoc.getEdocTitle());
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpEdocId")) {
								text = text.replace("tmpEdocId", edoc.getEdocId());
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpEmpNm")) {
								text = text.replace("tmpEmpNm", edoc.getEmpName());
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpEmpDt")) {
								text = text.replace("tmpEmpDt", edoc.getEdocDt());
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpSecuNm")) {
								text = text.replace("tmpSecuNm", edoc.getSecuCd());
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpPrsvDt")) {
								text = text.replace("tmpPrsvDt", edoc.getPrsvCd().equals("0")?"영구":edoc.getPrsvCd()+"년");
								r.setText(text, 0);
							}
							
							// 결재선(참조 부분 추가 필)
							// 결재선-이름
							if (text != null && text.contains("tmpF1.5")) {
								text = text.replace("tmpF1.5", FList.size()>=1?FList.get(0).getFlowNm():"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF1.4")) {
								text = text.replace("tmpF1.4", FList.size()>=2?FList.get(1).getFlowNm():"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF1.3")) {
								text = text.replace("tmpF1.3", FList.size()>=3?FList.get(2).getFlowNm():"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF1.2")) {
								text = text.replace("tmpF1.2", FList.size()>=4?FList.get(3).getFlowNm():"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF1.1")) {
								text = text.replace("tmpF1.1", FList.size()>=5?FList.get(4).getFlowNm():"");
								r.setText(text, 0);
							}
							// 결재선-서명란
							if (text != null && text.contains("tmpF2.5")) {
								text = text.replace("tmpF2.5", FList.size()>=1?FList.get(0).getFlowSt()!=null?"결재":"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF2.4")) {
								text = text.replace("tmpF2.4", FList.size()>=2?FList.get(1).getFlowSt()!=null?"결재":"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF2.3")) {
								text = text.replace("tmpF2.3", FList.size()>=3?FList.get(2).getFlowSt()!=null?"결재":"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF2.2")) {
								text = text.replace("tmpF2.2", FList.size()>=4?FList.get(3).getFlowSt()!=null?"결재":"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF2.1")) {
								text = text.replace("tmpF2.1", FList.size()>=5?FList.get(4).getFlowSt()!=null?"결재":"":"");
								r.setText(text, 0);
							}
							// 결재선-날짜란
							if (text != null && text.contains("tmpF3.5")) {
								text = text.replace("tmpF3.5", FList.size()>=1?FList.get(0).getFlowDt()!=null?FList.get(0).getFlowDt():"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF3.4")) {
								text = text.replace("tmpF3.4", FList.size()>=2?FList.get(1).getFlowDt()!=null?FList.get(1).getFlowDt():"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF3.3")) {
								text = text.replace("tmpF3.3", FList.size()>=3?FList.get(2).getFlowDt()!=null?FList.get(2).getFlowDt():"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF3.2")) {
								text = text.replace("tmpF3.2", FList.size()>=4?FList.get(3).getFlowDt()!=null?FList.get(3).getFlowDt():"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpF3.1")) {
								text = text.replace("tmpF3.1", FList.size()>=5?FList.get(4).getFlowDt()!=null?FList.get(4).getFlowDt():"":"");
								r.setText(text, 0);
							}
							// 협조란
							// 협조선-이름
							if (text != null && text.contains("tmpC1.3")) {
								text = text.replace("tmpC1.3", CList.size()>=1?CList.get(0).getFlowNm():"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpC1.2")) {
								text = text.replace("tmpC1.2", CList.size()>=2?CList.get(1).getFlowNm():"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpC1.1")) {
								text = text.replace("tmpC1.1", CList.size()>=3?CList.get(2).getFlowNm():"");
								r.setText(text, 0);
							}
							// 협조선-서명란
							if (text != null && text.contains("tmpC2.3")) {
								text = text.replace("tmpC2.3", CList.size()>=1?CList.get(0).getFlowSt()!=null?"결재":"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpC2.2")) {
								text = text.replace("tmpC2.2", CList.size()>=2?CList.get(1).getFlowSt()!=null?"결재":"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpC2.1")) {
								text = text.replace("tmpC2.1", CList.size()>=3?CList.get(2).getFlowSt()!=null?"결재":"":"");
								r.setText(text, 0);
							}
							// 협조선-날짜란

							if (text != null && text.contains("tmpC3.3")) {
								text = text.replace("tmpC3.3", CList.size()>=1?CList.get(0).getFlowDt()!=null?CList.get(0).getFlowDt():"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpC3.2")) {
								text = text.replace("tmpC3.2", CList.size()>=2?CList.get(1).getFlowDt()!=null?CList.get(1).getFlowDt():"":"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpC3.1")) {
								text = text.replace("tmpC3.1", CList.size()>=3?CList.get(2).getFlowDt()!=null?CList.get(2).getFlowDt():"":"");
								r.setText(text, 0);
							}
							
							
							// 참조란
							
							// 내용(휴가신청서) : if문으로 분기 시킬것.
							if (text != null && text.contains("tmpLeaveDt")) {
								text = text.replace("tmpLeaveDt", edocLeaveLtt.getStartDt()+" ~ "+edocLeaveLtt.getEndDt());
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpLeaveStc")) {
								text = text.replace("tmpLeaveStc", "");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpLeaveUsed")) {
								text = text.replace("tmpLeaveUsed", edocLeaveLtt.getLeaveAmt()+"일");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpLeaveType")) {
								text = text.replace("tmpLeaveType", edocLeaveLtt.getVctnNm());
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpLeavePurpose")) {
								text = text.replace("tmpLeavePurpose", edocLeaveLtt.getLeavePurpose()!=null?edocLeaveLtt.getLeavePurpose():"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpLeaveContact")) {
								text = text.replace("tmpLeaveContact", edocLeaveLtt.getLeaveContact()!=null?edocLeaveLtt.getLeaveContact():"");
								r.setText(text, 0);
							}
							if (text != null && text.contains("tmpLeaveAlter")) {
								text = text.replace("tmpLeaveAlter", edocLeaveLtt.getSurEmpName()!=null?edocLeaveLtt.getSurEmpName():"");
								r.setText(text, 0);
							}
							// 첨부파일
							if (text != null && text.contains("tmpEdocAtt")) {
								text = text.replace("tmpEdocAtt", AttList);
								r.setText(text, 0);
							}
						}
					}
				}
			}
		}
		EdocAtt edocAtt = write2Pdf(doc, request);
		doc.close();
		
		return edocAtt;
	}
	public EdocAtt write2Pdf(XWPFDocument doc, HttpServletRequest request) throws IOException {

		String optFolder = request.getServletContext().getRealPath("/resources/upload/edocPdf/");
		String originFilename = "createFileFromTemplate.pdf";
		String renamedFilename = Utils.getRefile(originFilename);
		String edocId = request.getParameter("edocId");
		
		
		File f = new File(optFolder);
		if (!f.exists()) {
			System.out.println("Created folder " + optFolder);
			f.mkdirs();
		}

		OutputStream out = new FileOutputStream(new File(optFolder + renamedFilename));
		PdfOptions options = PdfOptions.create().fontEncoding("Identity-H"); // Identity-H 인코딩 설정안하거나 UTF-8 등으로 설정하면 한글 안보임
		PdfConverter.getInstance().convert(doc, out, options);
		
		EdocAtt edocAtt = new EdocAtt();
		edocAtt.setOriginFilename(originFilename);
		edocAtt.setRenamedFilename(renamedFilename);
		edocAtt.setEdocId(edocId);
		
		return edocAtt;
	}
	@PostMapping("/flowExe.do")
	public String edocFlowExe(EdocFlow edocFlow, String edocTitleFromPage, HttpServletRequest request, HttpServletResponse response) throws Exception, IOException {
		request.setCharacterEncoding("utf-8");
		edocTitleFromPage = URLEncoder.encode(edocTitleFromPage, "UTF-8");
		log.debug("edocFlow.edocFlowExe@EdocController={}", edocFlow);

		int result = edocService.updateFlowExe(edocFlow);
		
		if(edocFlow.getFlowCd().equals("F1")||edocFlow.getFlowCd().equals("F2")) {
			int count = edocService.countSt(edocFlow);
			if(count == 0) {
				int complete = edocService.updateEdocSt(edocFlow);
			}
		}
		return "redirect:/edoc/edocSrchView.do?edocId="+edocFlow.getEdocId()+"&edocTitleFromPage="+edocTitleFromPage+"";
	}
	
	@GetMapping("/nameSrch.do") // 모달내 검색
	@ResponseBody
	public List<OrgChart> nameSrch() {

		List<OrgChart> orgChartList = edocService.selectNameSrch();
		log.debug("orgChartList.nameSrch@EdocController={}", orgChartList);
		return orgChartList;
	}
}
