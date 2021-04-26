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
package com.intel.storage.repository;

import com.intel.storage.model.Storage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Avinash Reddy Palleti
 * Storage Repository
 *
 */

@Repository
public interface StorageRepository extends JpaRepository<Storage, Long> {

    @Query(nativeQuery = true , value = "select * from gen2_storage s where s.user_id = :userId")
    public List<Storage> isUserIdExists(@Param("userId") Integer userId);


    public Storage findByDevCloudUserTabUserId(Integer userId);
    public default String getPvNameByUserId(@Param("userId") Integer userId)
    {
        Storage storage = findByDevCloudUserTabUserId(userId);
        if (storage != null)
            return storage.getPvName();
        else
            return null;
    }

}
