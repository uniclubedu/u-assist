package com.intel.cloud.byoc.model;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "tag_tab")
public class Tag {
	
	private Long  tag_id;
	private String   tag_name;
	private String   tag_description;
	private Integer  user_id; 
	
	public Tag(Long tag_id, String tag_name, String tag_description, Integer user_id) {
		super();
		this.tag_id = tag_id;
		this.tag_name = tag_name;
		this.tag_description = tag_description;
		this.user_id = user_id;
	}

	public Long getTag_id() {
		return tag_id;
	}

	public void setTag_id(Long tag_id) {
		this.tag_id = tag_id;
	}

	public String getTag_name() {
		return tag_name;
	}

	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}

	public String getTag_description() {
		return tag_description;
	}

	public void setTag_description(String tag_description) {
		this.tag_description = tag_description;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	@Override
	public String toString() {
		return "Tag [tag_id=" + tag_id + ", tag_name=" + tag_name + ", tag_description=" + tag_description
				+ ", user_id=" + user_id + "]";
	}
	
	
	

}
