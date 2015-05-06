package com.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="tb_sys_menu")
public class MenuBean implements Serializable,Comparable<MenuBean>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6061602356828095251L;
	@Id
	private int menuid;
	private int pid;
	private String menuname;
	private String menuhref;
	
	private int levelnum;
	private Boolean isParent;
	
	private String menu_icon;
	
	
	
	public String getMenu_icon() {
		return menu_icon;
	}
	public void setMenu_icon(String menu_icon) {
		this.menu_icon = menu_icon;
	}
	public Boolean getIsParent() {
		return isParent;
	}
	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}
	public int getMenuid() {
		return menuid;
	}
	public void setMenuid(int menuid) {
		this.menuid = menuid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public String getMenuhref() {
		return menuhref;
	}
	public void setMenuhref(String menuhref) {
		this.menuhref = menuhref;
	}
	public int getLevelnum() {
		return levelnum;
	}
	public void setLevelnum(int levelnum) {
		this.levelnum = levelnum;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + levelnum;
		result = prime * result
				+ ((menuhref == null) ? 0 : menuhref.hashCode());
		result = prime * result + menuid;
		result = prime * result
				+ ((menuname == null) ? 0 : menuname.hashCode());
		result = prime * result + pid;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MenuBean other = (MenuBean) obj;
		if (levelnum != other.levelnum)
			return false;
		if (menuhref == null) {
			if (other.menuhref != null)
				return false;
		} else if (!menuhref.equals(other.menuhref))
			return false;
		if (menuid != other.menuid)
			return false;
		if (menuname == null) {
			if (other.menuname != null)
				return false;
		} else if (!menuname.equals(other.menuname))
			return false;
		if (pid != other.pid)
			return false;
		return true;
	}
	public int compareTo(MenuBean o) {
		String id=String.valueOf(o.getMenuid());
		String thisid=String.valueOf(this.menuid);
		if(!thisid.equals(id)){
			return thisid.compareTo(id);
		}
		return 0;
	}
	
}
