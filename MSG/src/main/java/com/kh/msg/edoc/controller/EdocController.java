package com.kh.msg.edoc.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.MapUtils;
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
import com.kh.msg.edoc.model.vo.EdocAtt;
import com.kh.msg.edoc.model.vo.EdocFlow;
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
	public ModelAndView list(@RequestParam(value = "cPage", defaultValue = "1") int cPage, String srchWord,
			@RequestParam(value = "srchType", defaultValue = "all") String srchType,
			@RequestParam(value = "arrayDocuCheck", defaultValue = "myDocu,reqDocu,compDocu,refDocu") String[] arrayDocuCheck,
			HttpSession session) {
		log.debug("=========내 전자문서 페이지=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;

		OrgChart m = (OrgChart) session.getAttribute("memberLoggedIn");// 로그인 객체 호출

		// 일단 초기값은 모든 종류의 문서를 가져오는 것으로 가정
		String myDocu = "y";
		String reqDocu = "y";
		String compDocu = "y";
		String refDocu = "y";

		if (!Arrays.stream(arrayDocuCheck).anyMatch("myDocu"::equals))
			myDocu = "n";
		if (!Arrays.stream(arrayDocuCheck).anyMatch("reqDocu"::equals))
			reqDocu = "n";
		if (!Arrays.stream(arrayDocuCheck).anyMatch("compDocu"::equals))
			compDocu = "n";
		if (!Arrays.stream(arrayDocuCheck).anyMatch("refDocu"::equals))
			refDocu = "n";

		// docuCheckMap : 페이지 리다이렉트시 이전에 선택한 검색 조건을 유지 하기 위해 사용
		Map<String, String> docuCheckMap = new HashMap<String, String>();
		docuCheckMap.put("myDocu", myDocu);
		docuCheckMap.put("reqDocu", reqDocu);
		docuCheckMap.put("compDocu", compDocu);
		docuCheckMap.put("refDocu", refDocu);

		//
		Map<String, String> map = new HashMap<>();
		map.put("srchWord", srchWord);
		map.put("srchType", srchType);
		map.put("empNo", m.getEmpNo() + "");// member.getEmpNo()+""
		map.put("myDocu", myDocu);
		map.put("reqDocu", reqDocu);
		map.put("compDocu", compDocu);
		map.put("refDocu", refDocu);

		List<EdocSrch> list = edocService.selectMyList(cPage, numPerPage, map);

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
					+ srchType + "'>&laquo;</a>";
		}

		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				pageBar += "<a class='active'>" + pageNo + "</a>";
			} else {
				pageBar += "<a href='/msg/edoc/list.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType="
						+ srchType + "'>" + pageNo + "</a>";
			}
			pageNo++;
		}
		;
		if (pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		} else {
			pageBar += "<a href='/msg/edoc/list.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType=" + srchType
					+ "'>&raquo;</a>";
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
	public ModelAndView srch(@RequestParam(value = "cPage", defaultValue = "1") int cPage, String srchWord,
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
	public void edocWrite(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
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
            ef.setFlowEmpNo(Integer.parseInt(flowLine[4*i]));
            ef.setFlowOrd(i + 1);
            edocFlowList.add(ef);
        }
        
        
		// 전자문서 등록 파트
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
			edocLeaveLtt.setSurEmpNo(Integer.parseInt(surEmpNo));
		}
		edocLeaveLtt.setTypeCd(typeCd);

		
		int result = edocService.edocWrite(edocLeaveLtt, edocAttList, edocFlowList);
		log.debug("write.do@EdocController={}", result);
		
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
	public void jstreeMem(HttpServletRequest request, HttpServletResponse response) {
		if (request.getParameter("id").charAt(0) == 'D') {
			try {
				JSONObject sObject = new JSONObject();
				sObject.put("empNo", "fail");
				sObject.put("dept", "fail");
				sObject.put("job", "fail");
				sObject.put("name", "fail");

				response.setCharacterEncoding("UTF-8");
				PrintWriter out;
				out = response.getWriter();
				out.write(sObject.toString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			try {
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

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
	
	
//	@GetMapping("/edocSrchView.do") // 단순 이동용 임시 메소드. 아래 PostMapping된 메소드 완성되면 없앨 예정
	public String edocSrchViewGet(HttpServletRequest request, HttpServletResponse response)
			throws InvalidFormatException, IOException {

		return "edoc/edocSrchRead";
	}
	
	@GetMapping("/edocSrchView.do")
	public ModelAndView edocSrchViewPost(HttpServletRequest request, HttpServletResponse response, ModelAndView mav)
			throws InvalidFormatException, IOException {
		
		EdocAtt edocAtt = createDocFromTemplate(request);
		
		String attachId = edocService.insertPdf(edocAtt);
		
		mav.addObject("attachId", attachId);
		mav.setViewName("edoc/edocSrchRead");
		return mav;
	}

	// private static 으로 안하면 에러나려나?
	private static EdocAtt createDocFromTemplate(HttpServletRequest request) throws InvalidFormatException, IOException {
//	public String createDocFromTemplate(HttpServletRequest request) throws InvalidFormatException, IOException {

		// doc 템플릿 열 때에 읽기 쓰기 권한 획득
//		XWPFDocument doc = new XWPFDocument(OPCPackage.open("/resources/template/leaveTemplate.docx"));
		XWPFDocument doc = new XWPFDocument(OPCPackage.open(request.getServletContext().getRealPath("/resources/template/leaveTemplate.docx")));

		// doc 템플릿에 DB값 삽입
		for (XWPFParagraph p : doc.getParagraphs()) {
			List<XWPFRun> runs = p.getRuns();
			if (runs != null) {
				for (XWPFRun r : runs) {
					String text = r.getText(0);
					if (text != null && text.contains("tmp")) {
						text = text.replace("tmp", "임시");
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
							if (text != null && text.contains("tmp")) {
								text = text.replace("tmp", "임시");
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
	private static EdocAtt write2Pdf(XWPFDocument doc, HttpServletRequest request) throws IOException {
//	public String write2Pdf(XWPFDocument doc, HttpServletRequest request) throws IOException {

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
		PdfOptions options = PdfOptions.create().fontEncoding("Identity-H"); // 왜...Identity-H? 이거 설정안하거나 UTF-8 이런거 주면
																				// 한글 안보임
		PdfConverter.getInstance().convert(doc, out, options);
		
		EdocAtt edocAtt = new EdocAtt();
		edocAtt.setOriginFilename(originFilename);
		edocAtt.setRenamedFilename(renamedFilename);
		edocAtt.setEdocId(edocId);
		
		return edocAtt;
	}
	
}
