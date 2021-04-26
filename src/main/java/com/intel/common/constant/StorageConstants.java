package com.intel.common.constant;

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
public class StorageConstants {

    public static final String VOLUME_ID = "aws://us-east-2a/vol-0487fde76fc1b33b8";
    public static final Integer ALLOTED_SIZE = 1;
    public static final String FS_TYPE = "ext4";
    public static final String STORAGE_CLASSNAME = "ocs-storagecluster-cephfs";
    public static final String RECLAIM_POLICY = "Retain";
    public static final String ACCESS_MODE_RWO = "ReadWriteOnce";
    public static final String ACCESS_MODE_RWX = "ReadWriteMany";
    public static final String DOMAIN = "@intel.com";
    public static final String DOT = ".";

}
