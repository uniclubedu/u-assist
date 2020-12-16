package com.intel.cloud.byoc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.intel.cloud.byoc.model.QuotaTab;
import com.intel.cloud.byoc.repository.QuotaTabRepository;
import com.intel.cloud.byoc.service.QuotaTabService;
import org.springframework.stereotype.Service;

@Service
public class QuotaTabServiceImpl implements QuotaTabService {
	
	@Autowired
	QuotaTabRepository quotaTabRepository;

	@Override
	public List<QuotaTab> getQuota() {
		return (List<QuotaTab>) quotaTabRepository.findAll();
	}

}
