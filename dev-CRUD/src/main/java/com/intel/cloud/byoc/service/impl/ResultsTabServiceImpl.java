package com.intel.cloud.byoc.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.intel.cloud.byoc.model.ResultsTab;
import com.intel.cloud.byoc.repository.ResultsTabRepository;
import com.intel.cloud.byoc.service.ResultsTabService;

@Service
public class ResultsTabServiceImpl implements ResultsTabService {
	@Autowired
	private ResultsTabRepository resultsTabRepository;

	@Override
	public List<ResultsTab> getResults() {
		return (List<ResultsTab>) resultsTabRepository.findAll();
	}

}
