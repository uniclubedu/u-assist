package com.intel.cloud.byoc.service;

import java.util.List;

import com.intel.cloud.byoc.model.Container;

public interface ContainerService {
	
	
	public List<Container> findAll();
	
	public Container findById();
	

}
