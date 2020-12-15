package com.intel.cloud.byoc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.intel.cloud.byoc.model.ProfileTab;
import com.intel.cloud.byoc.repository.ProfileTabRepository;
import com.intel.cloud.byoc.service.ProfileTabService;
import org.springframework.stereotype.Service;


@Service
public class ProfileTabServiceImpl implements ProfileTabService {
	
	@Autowired
	ProfileTabRepository profileTabRepository;

	@Override
	public List<ProfileTab> getProfile() {
		return (List<ProfileTab>) profileTabRepository.findAll();
	}

}
