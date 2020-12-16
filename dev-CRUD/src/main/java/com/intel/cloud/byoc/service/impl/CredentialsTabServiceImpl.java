package com.intel.cloud.byoc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.intel.cloud.byoc.model.CredentialsTab;
import com.intel.cloud.byoc.repository.CredentialsTabRepository;
import com.intel.cloud.byoc.service.CredentialsTabService;
import org.springframework.stereotype.Service;

@Service
public class CredentialsTabServiceImpl implements CredentialsTabService {
	
	@Autowired
	CredentialsTabRepository credentialsTabRepository;

	@Override
	public List<CredentialsTab> getCredentials() {
		return (List<CredentialsTab>) credentialsTabRepository.findAll();
	}
	
	
}
