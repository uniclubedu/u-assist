package com.intel.cloud.byoc.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.intel.cloud.byoc.model.ConfigurationTab;
import com.intel.cloud.byoc.repository.ConfigurationTabRepository;
import com.intel.cloud.byoc.service.ConfigurationTabService;

@Service
public class ConfigurationTabServiceImpl implements ConfigurationTabService {
	@Autowired
	private ConfigurationTabRepository configurationTabRepository;

	@Override
	public List<ConfigurationTab> getConfiguration() {

		return (List<ConfigurationTab>) configurationTabRepository.findAll();
	}
	
}
