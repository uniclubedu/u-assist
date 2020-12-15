package com.intel.cloud.byoc.model;

import java.io.Serializable;

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
@Table(name = "profile_tab")
public class ProfileTab implements Serializable {
	
	private static final long serialVersionUID = -1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "profile_id")
	private int profileId;
	
	@Column(name = "user_profession")
	private String userProfession;
	
	@Column(name = "user_phone")
	private String userPhone;
	
	@Column(name = "user_address")
	private String userAddress;
	
	@Column(name = "user_description")
	private String userDescription;
	
	@Column(name = "user_email")
	private String userEmail;
	
	@OneToOne
	@JoinColumn(name = "user_id")
	private RegistrationTab registrationTab;
	
	
	public ProfileTab() {
		
	}


	public ProfileTab(int profileId, String userProfession, String userPhone, String userAddress,
			String userDescription, String userEmail, RegistrationTab registrationTab) {
		super();
		this.profileId = profileId;
		this.userProfession = userProfession;
		this.userPhone = userPhone;
		this.userAddress = userAddress;
		this.userDescription = userDescription;
		this.userEmail = userEmail;
		this.registrationTab = registrationTab;
	}

	
	public int getProfileId() {
		return profileId;
	}


	public void setProfileId(int profileId) {
		this.profileId = profileId;
	}


	public String getUserProfession() {
		return userProfession;
	}


	public void setUserProfession(String userProfession) {
		this.userProfession = userProfession;
	}


	public String getUserPhone() {
		return userPhone;
	}


	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}


	public String getUserAddress() {
		return userAddress;
	}


	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}


	public String getUserDescription() {
		return userDescription;
	}


	public void setUserDescription(String userDescription) {
		this.userDescription = userDescription;
	}


	public String getUserEmail() {
		return userEmail;
	}


	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
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
        builder.append("Profile [profileId=");
        builder.append(profileId);
        builder.append(",userId=");
        builder.append(registrationTab.getUserId());
        builder.append(", userProfession=");
        builder.append(userProfession);
        builder.append(",userPhone=");
        builder.append(userPhone);
        builder.append(",userAddress=");
        builder.append(userAddress);
        builder.append(",userDescription=");
        builder.append(userDescription);
        builder.append(",userEmail=");
        builder.append(userEmail);
        builder.append("]");
        return builder.toString();
		
		
	}


}
