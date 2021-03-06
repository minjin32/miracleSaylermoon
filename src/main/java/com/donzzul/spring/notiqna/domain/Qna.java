package com.donzzul.spring.notiqna.domain;

import java.sql.Date;

public class Qna {
	private int qnaNo;
	private String qnaTitle;
	private String qnaContent;
	private String qnaWriter;
	private String qanCreateDate;
	private String qanUploadDate;
	private String boardPublicYN; // char
	private String userType;
	private int userNo; // char
	private int originNo;
	private int groupOrder;
	private int groupLayer;
	private String qnaId;
	private int qnaHit;
	
	public Qna() {}

	public Qna(int qnaNo, String qnaTitle, String qnaContent, String qnaWriter, String qanCreateDate,
			String qanUploadDate, String boardPublicYN, String userType, int userNo, int originNo, int groupOrder,
			int groupLayer, String qnaId, int qnaHit) {
		super();
		this.qnaNo = qnaNo;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
		this.qnaWriter = qnaWriter;
		this.qanCreateDate = qanCreateDate;
		this.qanUploadDate = qanUploadDate;
		this.boardPublicYN = boardPublicYN;
		this.userType = userType;
		this.userNo = userNo;
		this.originNo = originNo;
		this.groupOrder = groupOrder;
		this.groupLayer = groupLayer;
		this.qnaId = qnaId;
		this.qnaHit = qnaHit;
	}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public String getQnaTitle() {
		return qnaTitle;
	}

	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}

	public String getQnaContent() {
		return qnaContent;
	}

	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}

	public String getQnaWriter() {
		return qnaWriter;
	}

	public void setQnaWriter(String qnaWriter) {
		this.qnaWriter = qnaWriter;
	}

	public String getQanCreateDate() {
		return qanCreateDate;
	}

	public void setQanCreateDate(String qanCreateDate) {
		this.qanCreateDate = qanCreateDate;
	}

	public String getQanUploadDate() {
		return qanUploadDate;
	}

	public void setQanUploadDate(String qanUploadDate) {
		this.qanUploadDate = qanUploadDate;
	}

	public String getBoardPublicYN() {
		return boardPublicYN;
	}

	public void setBoardPublicYN(String boardPublicYN) {
		this.boardPublicYN = boardPublicYN;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getOriginNo() {
		return originNo;
	}

	public void setOriginNo(int originNo) {
		this.originNo = originNo;
	}

	public int getGroupOrder() {
		return groupOrder;
	}

	public void setGroupOrder(int groupOrder) {
		this.groupOrder = groupOrder;
	}

	public int getGroupLayer() {
		return groupLayer;
	}

	public void setGroupLayer(int groupLayer) {
		this.groupLayer = groupLayer;
	}

	public String getQnaId() {
		return qnaId;
	}

	public void setQnaId(String qnaId) {
		this.qnaId = qnaId;
	}

	public int getQnaHit() {
		return qnaHit;
	}

	public void setQnaHit(int qnaHit) {
		this.qnaHit = qnaHit;
	}

	@Override
	public String toString() {
		return "Qna [qnaNo=" + qnaNo + ", qnaTitle=" + qnaTitle + ", qnaContent=" + qnaContent + ", qnaWriter="
				+ qnaWriter + ", qanCreateDate=" + qanCreateDate + ", qanUploadDate=" + qanUploadDate
				+ ", boardPublicYN=" + boardPublicYN + ", userType=" + userType + ", userNo=" + userNo + ", originNo="
				+ originNo + ", groupOrder=" + groupOrder + ", groupLayer=" + groupLayer + ", qnaId=" + qnaId
				+ ", qnaHit=" + qnaHit + "]";
	}

	
}
