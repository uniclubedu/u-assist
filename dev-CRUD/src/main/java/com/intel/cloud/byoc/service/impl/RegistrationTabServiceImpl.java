package com.intel.cloud.byoc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intel.cloud.byoc.model.RegistrationTab;
import com.intel.cloud.byoc.repository.RegistrationTabRepository;
import com.intel.cloud.byoc.service.RegistrationTabService;

@Service
public class RegistrationTabServiceImpl implements RegistrationTabService {
	@Autowired
	RegistrationTabRepository registrationTabRepository;
	
	public List<RegistrationTab> getRegistration() {
		return (List<RegistrationTab>) registrationTabRepository.findAll();
	}

}
