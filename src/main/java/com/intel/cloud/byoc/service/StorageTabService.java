package com.intel.cloud.byoc.service;

import java.util.List;
import com.intel.cloud.byoc.model.StorageTab;

public interface StorageTabService {
	StorageTab saveStorage(StorageTab storageTab);

	StorageTab finByuserId(int userId);

	public List<StorageTab> getStorage();
}
