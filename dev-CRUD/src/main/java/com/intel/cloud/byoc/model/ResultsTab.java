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
@Table(name = "results_tab")
public class ResultsTab implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="user_id")
	private int userId;
	
	@Column(name="result_id")
	private int resultId;
	
	@Column(name="container_id")
	private int containerId;
	
	@Column(name="result_location")
	private String resultLocation;
	
	@Column(name="result_execution_time")
	private int result_ExecutionTime;
	
	@Column(name="result_last_run")
	private String resultLastRun;
	
	@Column(name="result_pass")
	private boolean resultPass;
	
	@Column(name="result_name")
	private String resultName;

	public ResultsTab() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ResultsTab(int userId, int resultId, int containerId, String resultLocation, int result_ExecutionTime,
			String resultLastRun, boolean resultPass, String resultName) {
		super();
		this.userId = userId;
		this.resultId = resultId;
		this.containerId = containerId;
		this.resultLocation = resultLocation;
		this.result_ExecutionTime = result_ExecutionTime;
		this.resultLastRun = resultLastRun;
		this.resultPass = resultPass;
		this.resultName = resultName;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getResultId() {
		return resultId;
	}

	public void setResultId(int resultId) {
		this.resultId = resultId;
	}

	public int getContainerId() {
		return containerId;
	}

	public void setContainerId(int containerId) {
		this.containerId = containerId;
	}

	public String getResultLocation() {
		return resultLocation;
	}

	public void setResultLocation(String resultLocation) {
		this.resultLocation = resultLocation;
	}

	public int getResult_ExecutionTime() {
		return result_ExecutionTime;
	}

	public void setResult_ExecutionTime(int result_ExecutionTime) {
		this.result_ExecutionTime = result_ExecutionTime;
	}

	public String getResultLastRun() {
		return resultLastRun;
	}

	public void setResultLastRun(String resultLastRun) {
		this.resultLastRun = resultLastRun;
	}

	public boolean isResultPass() {
		return resultPass;
	}

	public void setResultPass(boolean resultPass) {
		this.resultPass = resultPass;
	}

	public String getResultName() {
		return resultName;
	}

	public void setResultName(String resultName) {
		this.resultName = resultName;
	}

	
}
