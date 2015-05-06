package com.common.vo;

import java.util.List;

public class Model<T> {
	private List<T> result;
	private int resultCount;

	public List<T> getResult() {
		return result;
	}

	public int getResultCount() {
		return resultCount;
	}

	public void setResult(List<T> result) {
		this.result = result;
	}

	public void setResultCount(int resultCount) {
		this.resultCount = resultCount;

	}
}
