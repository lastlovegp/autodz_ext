package com.base.common.bean;

import javax.persistence.Transient;

import com.base.common.bean.impl.BasePo;
import com.erp.framework.extuihelper.Ef;

public class TreeBean extends BasePo {

	@Ef(exclude = "1")
	private String lastFlag = "0";
	@Ef(exclude = "1")
	private String isRoot;
	@Ef(exclude = "1")
	private String iconCls;
	@Ef(exclude = "1")
	private String menupath;
	@Ef(exclude = "1")
	private boolean leaf;
	@Ef(exclude = "1")
	private boolean expanded;

	@Ef(itemExclude = true, colExclude = true)
	private String id;

	@Ef(exclude = "1")
	private String text;

	@Transient
	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	@Transient
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Transient
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Transient
	public String getLastFlag() {
		return lastFlag;
	}

	public void setLastFlag(String lastFlag) {
		this.lastFlag = lastFlag;
	}

	@Transient
	public boolean isExpanded() {
		return expanded;
	}

	public void setExpanded(boolean expanded) {
		this.expanded = expanded;
	}

	@Transient
	public boolean isLeaf() {
		return leaf;
	}

	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}

	@Transient
	public String getIsRoot() {
		return isRoot;
	}

	public void setIsRoot(String isRoot) {
		this.isRoot = isRoot;
	}

	@Transient
	public String getMenupath() {
		return menupath;
	}

	public void setMenupath(String menupath) {
		this.menupath = menupath;
	}

	/* [CONSTRUCTOR MARKER BEGIN] */
	public TreeBean() {
		super();
	}

	@Transient
	public PKey getPk() {
		// TODO Auto-generated method stub
		return null;
	}

	/* [CONSTRUCTOR MARKER END] */

}