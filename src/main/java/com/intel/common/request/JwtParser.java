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
/**
 * POJO for parsing jwt token
 *
 */
public class JwtParser {
    private String sub;

    private Access[] access;

    private String accountExpiry;

    private String userName;

    private String exp;

    private Integer userId;

    private String iat;

    private Integer daysLeft;

    public String getSub() {
        return sub;
    }

    public void setSub(String sub) {
        this.sub = sub;
    }

    public Access[] getAccess() {
        return access;
    }

    public void setAccess(Access[] access) {
        this.access = access;
    }

    public String getAccountExpiry() {
        return accountExpiry;
    }

    public void setAccountExpiry(String accountExpiry) {
        this.accountExpiry = accountExpiry;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getExp() {
        return exp;
    }

    public void setExp(String exp) {
        this.exp = exp;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getIat() {
        return iat;
    }

    public void setIat(String iat) {
        this.iat = iat;
    }

    public Integer getDaysLeft() {
        return daysLeft;
    }

    public void setDaysLeft(Integer daysLeft) {
        this.daysLeft = daysLeft;
    }

    @Override
    public String toString() {
        return "ClassPojo [sub = " + sub + ", access = " + access + ", accountExpiry = " + accountExpiry
                + ", userName = " + userName + ", exp = " + exp + ", userId = " + userId + ", iat = " + iat + "]";
    }


}

