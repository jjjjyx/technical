package com.model;

public class OperateImage {
	private String srcpath;
    // ===剪切点x坐标  
    private int x;  
    private int y;  
    // ===剪切点宽度  
    private int width;  
    private int height;  
    public OperateImage() {  
    }
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public String getSrcpath() {
		return srcpath;
	}
	public void setSrcpath(String srcpath) {
		this.srcpath = srcpath;
	}  
    
    
}
