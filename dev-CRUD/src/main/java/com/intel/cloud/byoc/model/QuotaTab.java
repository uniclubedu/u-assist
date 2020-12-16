package com.intel.cloud.byoc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(value = JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "quota_tab")
public class QuotaTab {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "quota_id")
	private int quotaId;
	
	@Column(name = "user_num_running_jobs")
	private int userNumRunningJobs;
	
	@Column(name = "user_number_processors")
	private int userNumProcessors;
	
	@OneToOne
	@JoinColumn(name = "user_id")
	private RegistrationTab registrationTab;
	
	
	public QuotaTab() {
		
	}


	public QuotaTab(int quotaId, int userNumRunningJobs, int userNumProcessors, RegistrationTab registrationTab) {
		super();
		this.quotaId = quotaId;
		this.userNumRunningJobs = userNumRunningJobs;
		this.userNumProcessors = userNumProcessors;
		this.registrationTab = registrationTab;
	}


	public int getQuotaId() {
		return quotaId;
	}


	public void setQuotaId(int quotaId) {
		this.quotaId = quotaId;
	}


	public int getUserNumRunningJobs() {
		return userNumRunningJobs;
	}


	public void setUserNumRunningJobs(int userNumRunningJobs) {
		this.userNumRunningJobs = userNumRunningJobs;
	}


	public int getUserNumProcessors() {
		return userNumProcessors;
	}


	public void setUserNumProcessors(int userNumProcessors) {
		this.userNumProcessors = userNumProcessors;
	}


	public RegistrationTab getRegistrationTab() {
		return registrationTab;
	}


	public void setRegistrationTab(RegistrationTab registrationTab) {
		this.registrationTab = registrationTab;
	}
	
	
	@Override
	public String toString() {
		 StringBuilder builder = new StringBuilder();
		 builder.append("Quota [quotaId=");
		 builder.append(quotaId);
		 builder.append(", userId=");
	     builder.append(registrationTab.getUserId());
	     builder.append(", userNumRunningJobs=");
	     builder.append(userNumRunningJobs);
	     builder.append(", userNumProcessors=");
	     builder.append(userNumProcessors);
         builder.append("]");
	     return builder.toString();
	}

	

}
