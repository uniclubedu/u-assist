package com.intel.cloud.byoc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "container_tab")
public class Container {

	private long  user_id;
	private Integer container_id; 
	private Boolean container_type;
	private String container_description;
	private String container_registry_location;
	private Integer tag_id;
	
	
	public Container(Long user_id, Integer container_id, Boolean container_type, String container_description,
			String container_registry_location, Integer tag_id) {
		super();
		this.user_id = user_id;
		this.container_id = container_id;
		this.container_type = container_type;
		this.container_description = container_description;
		this.container_registry_location = container_registry_location;
		this.tag_id = tag_id;
	}
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
		
	
	@Column(name = "container_id", nullable = false)
	public Integer getContainer_id() {
		return container_id;
	}
	public void setContainer_id(Integer container_id) {
		this.container_id = container_id;
	}
	@Column(name = "container_type", nullable = false)
	public Boolean getContainer_type() {
		return container_type;
	}
	public void setContainer_type(Boolean container_type) {
		this.container_type = container_type;
	}
	
	@Column(name = "container_description", nullable = false)
	public String getContainer_description() {
		return container_description;
	}
	public void setContainer_description(String container_description) {
		this.container_description = container_description;
	}
	
	
	@Column(name = "container_registry_location", nullable = false)
	public String getContainer_registry_location() {
		return container_registry_location;
	}
	public void setContainer_registry_location(String container_registry_location) {
		this.container_registry_location = container_registry_location;
	}
	
	
	@Column(name = "tag_id", nullable = false)
	public Integer getTag_id() {
		return tag_id;
	}
	public void setTag_id(Integer tag_id) {
		this.tag_id = tag_id;
	}
	
	
	
	
	
	@Override
	public String toString() {
		return "Container [user_id=" + user_id + ", container_id=" + container_id + ", container_type=" + container_type
				+ ", container_description=" + container_description + ", container_registry_location="
				+ container_registry_location + ", tag_id=" + tag_id + "]";
	}
	
}
