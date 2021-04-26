package com.intel.common.request;
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
import java.util.Arrays;

/**
 * @author dgawrix
 * POJO for parsing JWT token
 *
 */
public class Access {
    private String[] privileges;

    private String role;

    public String[] getPrivileges() {
        return privileges;
    }

    public void setPrivileges(String[] privileges) {
        this.privileges = privileges;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Access [privileges=" + Arrays.toString(privileges) + ", role=" + role + "]";
    }



}
