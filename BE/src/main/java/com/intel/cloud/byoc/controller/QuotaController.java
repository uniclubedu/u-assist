package com.intel.cloud.byoc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.intel.cloud.byoc.model.QuotaTab;
import com.intel.cloud.byoc.service.QuotaTabService;

@RestController
@RequestMapping(value = "/quota")
public class QuotaController {
	
	@Autowired
	QuotaTabService quotaTabService;
	
	@GetMapping(value = "/getAll" , produces = {"application/json"})
	public ResponseEntity<List<QuotaTab>> getAll() {
		List<QuotaTab> quotaLst = quotaTabService.getQuota();
		return new ResponseEntity<>(quotaLst,
				(quotaLst != null && quotaLst.size() > 0) ? HttpStatus.OK : HttpStatus.NO_CONTENT);

	}

	

}
