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
package com.intel.storage.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.intel.common.model.DevCloudUser;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @author Avinash Reddy Palleti
 * Storage Model
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(value = JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({"name","description"})
@Entity
@Table(name = "gen2_storage")
public class Storage implements Serializable {
    private static final long serialVersionUID = -1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id")
    private Long storageId;

    @Column(name = "pv_name")
    private String pvName;

    @Column(name = "storage_type")
    private String storageType;

    @Column(name = "alloted_size_gb")
    private Long allotedSize;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    @JsonIgnore
    private DevCloudUser devCloudUserTab;

    public Storage() {
    }

    public Storage(Long storageId, String pvName, String storageType, Long allotedSize) {
        this.storageId = storageId;
        this.allotedSize = allotedSize;
        this.pvName = pvName;
        this.storageType = storageType;
    }

    public Long getStorageId() {
        return storageId;
    }

    public void setStorageId(Long storageId) {
        this.storageId = storageId;
    }

    public String getPvName() {
        return pvName;
    }

    public void setPvName(String pvName) {
        this.pvName = pvName;
    }

    public String getStorageType() {
        return storageType;
    }

    public void setStorageType(String storageType) {
        this.storageType = storageType;
    }

    public Long getAllotedSize() {
        return allotedSize;
    }

    public void setAllotedSize(Long allotedSize) {
        this.allotedSize = allotedSize;
    }

    public DevCloudUser getDevCloudUserTab() {
        return devCloudUserTab;
    }

    public void setDevCloudUserTab(DevCloudUser devCloudUserTab) {
        this.devCloudUserTab = devCloudUserTab;
    }

    @Override
    public String toString() {
        return "Storage{" +
                "storageId=" + storageId +
                ", pvName='" + pvName + '\'' +
                ", storageType='" + storageType + '\'' +
                ", allotedSize=" + allotedSize +
                '}';
    }
}
