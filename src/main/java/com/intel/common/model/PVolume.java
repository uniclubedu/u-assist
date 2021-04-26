/*******************************************************************************
 * // Copyright (c) 2021 Intel Corporation
 * //
 * // Licensed under the Apache License, Version 2.0 (the "License");
 * // you may not use this file except in compliance with the License.
 * // You may obtain a copy of the License at
 * //
 * //      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * //
 * // Unless required by applicable law or agreed to in writing, software
 * // distributed under the License is distributed on an "AS IS" BASIS,
 * // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * // See the License for the specific language governing permissions and
 * // limitations under the License.
 ******************************************************************************/

package com.intel.common.model;

import java.util.Map;

/**
 * @author shuklaad
 *
 */
public class PVolume {

	private String pvName;
	private Integer capacity;
	private String accessMode;
	private String pvReclaimPolicy;
	private String storageClassName;
	private String fsType;
	private String volumeId;
	private String userName;

	public Integer getCapacity() {
		return capacity;
	}
	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}
	public String getAccessMode() {
		return accessMode;
	}
	public void setAccessMode(String accessMode) {
		this.accessMode = accessMode;
	}
	public String getPvReclaimPolicy() {
		return pvReclaimPolicy;
	}
	public void setPvReclaimPolicy(String pvReclaimPolicy) {
		this.pvReclaimPolicy = pvReclaimPolicy;
	}
	public String getStorageClassName() {
		return storageClassName;
	}
	public void setStorageClassName(String storageClassName) {
		this.storageClassName = storageClassName;
	}
	public String getFsType() {
		return fsType;
	}
	public void setFsType(String fsType) {
		this.fsType = fsType;
	}
	public String getVolumeId() {
		return volumeId;
	}
	public void setVolumeId(String volumeId) {
		this.volumeId = volumeId;
	}
	public String getPvName() {
		return pvName;
	}
	public void setPvName(String pvName) {
		this.pvName = pvName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserName() {
		return userName;
	}
}
