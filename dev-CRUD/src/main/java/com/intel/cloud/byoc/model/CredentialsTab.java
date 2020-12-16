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
@Table(name = "credentials_tab")
public class CredentialsTab implements Serializable {
	
	private static final long serialVersionUID = -1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cred_id")
	private int credId;

	@Column(name = "user_expiration")
	private int userExpiration;
	
	@Column(name = "user_role")
	private String userRole;
	
	@Column(name = "user_last_login")
	private int userLastLogin;
	
	@OneToOne
	@JoinColumn(name = "user_id")
	private RegistrationTab registrationTab;
	
	
	public CredentialsTab() {
		
	}

	
	public CredentialsTab(int credId, int userExpiration, String userRole, int userLastLogin,
			RegistrationTab registrationTab) {
		super();
		this.credId = credId;
		this.userExpiration = userExpiration;
		this.userRole = userRole;
		this.userLastLogin = userLastLogin;
		this.registrationTab = registrationTab;
	}




	public int getCredId() {
		return credId;
	}


	public void setCredId(int credId) {
		this.credId = credId;
	}


	public int getUserExpiration() {
		return userExpiration;
	}


	public void setUserExpiration(int userExpiration) {
		this.userExpiration = userExpiration;
	}
	
	
	public String getUserRole() {
		return userRole;
	}


	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}


	public int getUserLastLogin() {
		return userLastLogin;
	}


	public void setUserLastLogin(int userLastLogin) {
		this.userLastLogin = userLastLogin;
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
		builder.append("Credentials [credentialId=");
		builder.append(credId);
		builder.append(", userId=");
        builder.append(registrationTab.getUserId());
		builder.append(", userExpiration=");
        builder.append(userExpiration);
        builder.append(", userRole=");
        builder.append(userRole);
        builder.append(", userLastLogin=");
        builder.append(userLastLogin);
        builder.append("]");
        return builder.toString();
	}
	

}
