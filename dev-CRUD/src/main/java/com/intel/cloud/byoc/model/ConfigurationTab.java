package com.intel.cloud.byoc.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(value = JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "configuration_tab")
public class ConfigurationTab implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="user_id")
	private int userId;
	
	@Column(name="configuration_id")
	private int configurationId;
	
	@Column(name ="port_values")
	private String portValues;
	
	@Column(name = "accelertor_id")
	private int accelertorId;
	
	@Column(name = "configuration_name")
	private String configurationName;
	
	//private RegistrationTab registrationTab;

	public ConfigurationTab() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ConfigurationTab(int userId, int configurationId, String portValues, int accelertorId,
			String configurationName) {
		super();
		this.userId = userId;
		this.configurationId = configurationId;
		this.portValues = portValues;
		this.accelertorId = accelertorId;
		this.configurationName = configurationName;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getConfigurationId() {
		return configurationId;
	}

	public void setConfigurationId(int configurationId) {
		this.configurationId = configurationId;
	}

	public String getPortValues() {
		return portValues;
	}

	public void setPortValues(String portValues) {
		this.portValues = portValues;
	}

	public int getAccelertorId() {
		return accelertorId;
	}

	public void setAccelertorId(int accelertorId) {
		this.accelertorId = accelertorId;
	}

	public String getConfigurationName() {
		return configurationName;
	}

	public void setConfigurationName(String configurationName) {
		this.configurationName = configurationName;
	}

	
}
