package com.example.academylms.dto;

import lombok.Data;

@Data
public class Page {
	private int currentPage;
	private int rowPerPage;
	private int beginRow;
	private int totalPage;
	private String searchWord;
	
	// 검색 없는 페이징
	public Page(int currentPage, int rowPerPage, int totalPage){
	 		this.rowPerPage = rowPerPage;
                                                 			this.currentPage = currentPage;
			this.totalPage = totalPage;
			this.beginRow = (currentPage-1)*rowPerPage;
	 }
	
	// 검색 있는 페이징
	public Page(int currentPage, int rowPerPage, int totalPage, String searchWord){
 		this.rowPerPage = rowPerPage;
		this.currentPage = currentPage;
		this.totalPage = totalPage;
		this.searchWord = searchWord;
		this.beginRow = (currentPage-1)*rowPerPage;
	}
	
	// 마지막 페이지
	public int getLastPage() {
		int lastPage = this.totalPage / this.rowPerPage;
		if(this.totalPage % this.rowPerPage != 0) {
			lastPage++;
		}
		return lastPage;
	}
}
