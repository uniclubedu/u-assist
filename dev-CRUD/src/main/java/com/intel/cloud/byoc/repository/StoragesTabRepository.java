package com.intel.cloud.byoc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.intel.cloud.byoc.model.StorageTab;

@Repository
public interface StoragesTabRepository extends JpaRepository<StorageTab, Long>{
	public StorageTab getByUserId(int userId);
}
