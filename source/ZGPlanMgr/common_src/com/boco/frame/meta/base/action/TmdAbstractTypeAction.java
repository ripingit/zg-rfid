/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 */

package com.boco.frame.meta.base.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.org.rapid_framework.beanutils.BeanUtils;

import com.opensymphony.xwork2.Preparable;
import com.opensymphony.xwork2.ModelDriven;

import java.util.*;

import javacommon.base.*;
import javacommon.util.*;

import cn.org.rapid_framework.util.*;
import cn.org.rapid_framework.web.util.*;
import cn.org.rapid_framework.page.*;
import cn.org.rapid_framework.page.impl.*;

import com.boco.frame.meta.base.model.*;
import com.boco.frame.meta.base.dao.*;
import com.boco.frame.meta.base.service.*;

/**
 * @author badqiu email:badqiu(a)gmail.com
 * @version 1.0
 * @since 1.0
 */


public class TmdAbstractTypeAction extends BaseStruts2Action implements Preparable,ModelDriven{
	//默认多列排序,example: username desc,createTime asc
	protected static final String DEFAULT_SORT_COLUMNS = null; 
	
	//forward paths
	protected static final String QUERY_JSP = "/frame/meta/TmdAbstractType/query_TmdAbstractType.jsp";
	protected static final String LIST_JSP= "/frame/meta/TmdAbstractType/list_TmdAbstractType.jsp";
	protected static final String CREATE_JSP = "/frame/meta/TmdAbstractType/create_TmdAbstractType.jsp";
	protected static final String EDIT_JSP = "/frame/meta/TmdAbstractType/edit_TmdAbstractType.jsp";
	protected static final String SHOW_JSP = "/frame/meta/TmdAbstractType/show_TmdAbstractType.jsp";
	//redirect paths,startWith: !
	protected static final String LIST_ACTION = "!/frame/meta/TmdAbstractType/list.do";
	
	private TmdAbstractTypeManager tmdAbstractTypeManager;
	
	private TmdAbstractType tmdAbstractType;
	java.lang.String id = null;
	private String[] items;

	public void prepare() throws Exception {
		if (isNullOrEmptyString(id)) {
			tmdAbstractType = new TmdAbstractType();
		} else {
			tmdAbstractType = (TmdAbstractType)tmdAbstractTypeManager.getById(id);
		}
	}
	
	/** 增加setXXXX()方法,spring就可以通过autowire自动设置对象属性 */
	public void setTmdAbstractTypeManager(TmdAbstractTypeManager manager) {
		this.tmdAbstractTypeManager = manager;
	}	
	
	public Object getModel() {
		return tmdAbstractType;
	}
	
	public void setCuid(java.lang.String val) {
		this.id = val;
	}

	public void setItems(String[] items) {
		this.items = items;
	}

	/** 进入查询页面 */
	public String query() {
		return QUERY_JSP;
	}
	
	/** 执行搜索 */
	public String list() {
		PageRequest<Map> pageRequest = newPageRequest(DEFAULT_SORT_COLUMNS);
		//pageRequest.getFilters().put("key",value);     //add custom filter
		
		Page page = tmdAbstractTypeManager.findByPageRequest(pageRequest);
		savePage(page,pageRequest);
		return LIST_JSP;
	}
	
	/** 查看对象*/
	public String show() {
		return SHOW_JSP;
	}
	
	/** 进入新增页面*/
	public String create() {
		return CREATE_JSP;
	}
	
	/** 保存新增对象 */
	public String save() {
		tmdAbstractTypeManager.save(tmdAbstractType);
		return LIST_ACTION;
	}
	
	/**进入更新页面*/
	public String edit() {
		return EDIT_JSP;
	}
	
	/**保存更新对象*/
	public String update() {
		tmdAbstractTypeManager.update(this.tmdAbstractType);
		return LIST_ACTION;
	}
	
	/**删除对象*/
	public String delete() {
		for(int i = 0; i < items.length; i++) {
			Hashtable params = HttpUtils.parseQueryString(items[i]);
			java.lang.String id = new java.lang.String((String)params.get("cuid"));
			tmdAbstractTypeManager.removeById(id);
		}
		return LIST_ACTION;
	}

}
