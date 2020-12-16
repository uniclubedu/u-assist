package com.intel.cloud.byoc.model;

import java.io.Serializable;
import javax.persistence.CascadeType;
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
@Table(name = "storage_tab")
public class StorageTab implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id")
	private int userId;
	
	@Column(name="storage_uuid")
	private int storageUuId;
	
	@Column(name="storage_encryption_type")
	private String storageEncryptionType;
	
	@OneToOne()
	@JoinColumn(name = "user_id")
    private RegistrationTab registrationTab;
	public StorageTab() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StorageTab(int userId, int storageUuId, String storageEncryptionType) {
		super();
		this.userId = userId;
		this.storageUuId = storageUuId;
		this.storageEncryptionType = storageEncryptionType;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getStorageUuId() {
		return storageUuId;
	}

	public void setStorageUuId(int storageUuId) {
		this.storageUuId = storageUuId;
	}

	public String getStorageEncryptionType() {
		return storageEncryptionType;
	}

	public void setStorageEncryptionType(String storageEncryptionType) {
		this.storageEncryptionType = storageEncryptionType;
	}

}
