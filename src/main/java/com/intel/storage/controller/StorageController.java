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
package com.intel.storage.controller;

import com.intel.common.request.JwtParser;
import com.intel.common.util.JwtTokenUtil;
import com.intel.storage.model.StorageDTO;
import com.intel.storage.service.StorageService;
import com.nimbusds.jwt.SignedJWT;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Avinash Reddy Palleti
 * Storage controller
 *
 */

@RestController
@Api(value = "storage-api")
@RequestMapping(value = "/api/v1/storage")
public class StorageController {
    private static final Logger LOGGER = LoggerFactory.getLogger(StorageController.class);

    @Autowired
    StorageService storageService;

    @ApiOperation(value = "Allocate pre-defined storage for user based on user category")
    @RequestMapping(value = "/allot", method = RequestMethod.POST, produces = "application/json")
    public ResponseEntity<Map<String, String>> allotStorage(Authentication authentication) {
        Map<String, String> responseMap = new HashMap<>();
        JwtParser details = JwtTokenUtil.parseJwtToObject((SignedJWT)authentication.getPrincipal());
        LOGGER.info("Allot storage to user := " + details.getUserId());
        if(storageService.allotStorage(details.getUserId()))
            responseMap.put("response", "Storage allotment is successful");
        else
            responseMap.put("response", "Error in storage allotment");
        return new ResponseEntity<>(responseMap, HttpStatus.OK);
    }

    @ApiOperation(value = "Get PV name alloted for the user")
    @RequestMapping(value = "/pv", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<StorageDTO> getPV(Authentication authentication) {
        Map<String, String> responseMap = new HashMap<>();
        JwtParser details = JwtTokenUtil.parseJwtToObject((SignedJWT)authentication.getPrincipal());
        LOGGER.info("Getting PV name for the user := " + details.getUserId());
        StorageDTO storageDTO = storageService.getPV(details.getUserId());
        if(storageDTO != null)
            return new ResponseEntity<>(storageDTO, HttpStatus.OK);
        else
            return new ResponseEntity<>(null, HttpStatus.NO_CONTENT);
    }
}
