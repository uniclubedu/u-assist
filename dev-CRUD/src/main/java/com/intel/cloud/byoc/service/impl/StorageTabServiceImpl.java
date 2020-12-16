package com.intel.cloud.byoc.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.intel.cloud.byoc.model.StorageTab;
import com.intel.cloud.byoc.repository.StoragesTabRepository;
import com.intel.cloud.byoc.service.StorageTabService;

@Service
public class StorageTabServiceImpl implements StorageTabService {
	@Autowired
	private StoragesTabRepository storageTabRepository;

	@Override
	public StorageTab saveStorage(StorageTab storageTab) {
		return storageTabRepository.save(storageTab);
	}

	@Override
	public StorageTab finByuserId(int userId) {
		return storageTabRepository.getByUserId(userId);
	}

	@Override
	public List<StorageTab> getStorage() {
		return (List<StorageTab>) storageTabRepository.findAll();
	}

}
