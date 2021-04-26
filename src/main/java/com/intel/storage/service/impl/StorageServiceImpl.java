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
package com.intel.storage.service.impl;



import java.security.SecureRandom;

import com.intel.common.constant.StorageConstants;
import com.intel.storage.model.StorageDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.intel.common.exception.BadRequestException;
import com.intel.common.exception.BaseException;
import com.intel.common.exception.RepositoryException;
import com.intel.common.model.PVolume;
import com.intel.storage.model.Storage;
import com.intel.storage.repository.DevCloudUserRepository;
import com.intel.storage.repository.StorageRepository;
import com.intel.storage.service.StorageService;

import net.minidev.json.JSONObject;
import com.intel.common.constant.SecurityConstants;

/**
 * @author Avinash Reddy Palleti
 * Storage Service implementation
 * @author Avinash Reddy Palleti Storage Service implementation
 *
 */

@Service
public class StorageServiceImpl implements StorageService{
    @Autowired
    StorageRepository storageRepository;
    @Autowired
    DevCloudUserRepository devCloudUserTabRepository;
    
    @Autowired
    private RestTemplate restTemplate;
    
	@Value("${devcloud.pv.url}")
	private String devCloudOpenShiftUrl;

    private static final Logger LOGGER = LoggerFactory.getLogger(StorageServiceImpl.class);
    @Override
    public boolean allotStorage(Integer userId) {
        /*Check if user already exists in storage table
        If yes, return false
        If No, create PV
        PV name : generate 5 digit random number and suffix it to user name
         */
        try {
            if (storageRepository.isUserIdExists(userId).size() > 0) {
                throw new BadRequestException("Storage is already allotted to this user: " + userId);
            }
            LOGGER.info("allot space for :: userId:{}", userId);
            String userName = devCloudUserTabRepository.findByUserId(userId).getUserName();
            //userName = userName.replaceAll("[^a-zA-Z0-9].*", "");
            userName = extractUserNameFromEmail(userName);
            SecureRandom random = new SecureRandom();
            int num = random.nextInt(100000);
            String pvName = userName + String.format("%05d", num);
            PVolume pVolume = new PVolume();
            pVolume.setPvName(pvName);
            pVolume.setVolumeId(StorageConstants.VOLUME_ID);
            pVolume.setAccessMode(StorageConstants.ACCESS_MODE_RWX);
            pVolume.setCapacity(StorageConstants.ALLOTED_SIZE);
            pVolume.setFsType(StorageConstants.FS_TYPE);
            pVolume.setPvReclaimPolicy(StorageConstants.RECLAIM_POLICY);
            pVolume.setStorageClassName(StorageConstants.STORAGE_CLASSNAME);
            pVolume.setUserName(userName);
            LOGGER.info("allot space with pvName :: " + pvName );
            //TODO Check user type and decide on storage
            //Create PV with PV name. call api
            createPVC(pVolume);
            LOGGER.info("PVC is created");
            //Insert entry into storage table
            Storage s = new Storage();
            s.setAllotedSize(StorageConstants.ALLOTED_SIZE.longValue());
            s.setPvName(pvName);
            s.setStorageType("local");
            s.setDevCloudUserTab(devCloudUserTabRepository.findByUserId(userId));
            storageRepository.save(s);
            return true;

        } catch (DataAccessException ex) {
            LOGGER.error("DataAccessException occured...", ex);
            return false;
        } catch (Exception e) {
            LOGGER.error("Exception Occured: ", e);
            return false;
        }
    }
    
    /**
	 * @return
	 */
	private void createPVC(PVolume pVolume) {
		try {
			HttpHeaders headers = new HttpHeaders();
			headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
			HttpEntity<?> entity = new HttpEntity<>(pVolume, headers);
			restTemplate.exchange(devCloudOpenShiftUrl, HttpMethod.POST, entity,
					String.class);

		} catch (RestClientException e) {
			throw new BadRequestException("Exception occured while creating PVC:" + pVolume.getPvName());
		}

	}

    private String extractUserNameFromEmail(String userName) {
        userName = userName.replace(StorageConstants.DOMAIN, "");
        userName = userName.replace(StorageConstants.DOT, "");
        userName = userName.toLowerCase();
        LOGGER.info("userName: " +userName);
        return userName.trim();
    }

    @Override
    public StorageDTO getPV(Integer userId) {
        LOGGER.info("getPV :: userId:{}", userId);
        StorageDTO storageDTO = new StorageDTO();
        try {
            if (!devCloudUserTabRepository.existsById(userId)) {
                throw new BadRequestException("user id does not exist: " + userId);
            }

            String pvName =storageRepository.getPvNameByUserId(userId);
            LOGGER.info("PVC Name>>>>>>>"+pvName);
            if(pvName == null)
                return null;

            storageDTO.setPvcName(pvName);
            storageDTO.setPvName(pvName);
            return storageDTO;
        }
        catch (DataAccessException ex) {
            LOGGER.error("DataAccessException occured...", ex);
            throw new RepositoryException("DataAccessException occured", ex);
        } catch (Exception e) {
            LOGGER.error("Exception Occured: ", e);
            throw new BaseException("Exception Occured:", e);
        }

    }
}

