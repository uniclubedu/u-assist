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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(value = JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "name", "description" })
@Entity
@Table(name = "gen2_devcloud_user")
public class DevCloudUser implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * Integer value for storing userId
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "user_id")
    @JsonIgnore
    private Integer userId;

    /**
     * String value for storing email id
     */
    @Column(name = "user_name")
    private String userName;

    @Column(name = "user_expiration")
    private Date userExpiration;

    @Column(name = "user_last_login")
    private Date userLastLogin;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getUserExpiration() {
        return userExpiration;
    }

    public void setUserExpiration(Date userExpiration) {
        this.userExpiration = userExpiration;
    }

    public Date getUserLastLogin() {
        return userLastLogin;
    }

    public void setUserLastLogin(Date userLastLogin) {
        this.userLastLogin = userLastLogin;
    }

    @Override
    public String toString() {
        return "DevCloudUser [userId=" + userId + ", userName=" + userName + ", userExpiration=" + userExpiration
                + ", userLastLogin=" + userLastLogin + "]";
    }

}
