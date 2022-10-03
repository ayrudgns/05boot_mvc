package com.idev.boot.dto;

public class Schedule {
	private int idx;
	private int mno;
	private String title;
	private String sdate;
	private String stime;	// 테이블에는 없는 컬럼. view(jsp)에서 전달받기 위함.
	
	public Schedule() {	
		
	}
	
	public Schedule(int idx, int mno, String title, String sdate) {
		this.idx = idx;
		this.mno = mno;
		this.title = title;
		this.sdate = sdate;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	@Override
	public String toString() {
		return "Schedule [idx = " + idx + ", mno = " + mno + ", title = " + title + ", sdate = " + sdate + "]";
	}

	public String getStime() {
		return stime;
	}

	public void setStime(String stime) {
		this.stime = stime;
	}

	
}
