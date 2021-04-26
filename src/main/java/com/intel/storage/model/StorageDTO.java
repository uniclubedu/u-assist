package com.intel.storage.model;

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
import java.util.Date;

/**
 * @Description: Represents Storage Response
 *
 *
 */
public class StorageDTO {


    private String pvName;

    private String pvcName;

    public StorageDTO() {

    }

    public StorageDTO(String pvName, String pvcName) {
        this.pvName = pvName;
        this.pvcName = pvcName;
    }

    public String getPvName() {
        return pvName;
    }

    public String getPvcName() {
        return pvcName;
    }

    public void setPvName(String pvName) {
        this.pvName = pvName;
    }

    public void setPvcName(String pvcName) {
        this.pvcName = pvcName;
    }

    @Override
    public String toString() {
        return "Storage [pvName=" + pvName + ", pvcName=" + pvcName + "]";
    }



}