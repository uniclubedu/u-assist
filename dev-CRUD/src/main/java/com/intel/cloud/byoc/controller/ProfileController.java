package com.intel.cloud.byoc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.intel.cloud.byoc.model.ProfileTab;
import com.intel.cloud.byoc.service.ProfileTabService;

@RestController
@RequestMapping(value = "/profile")
public class ProfileController {
	
	@Autowired
	ProfileTabService profileTabService;
	
	@GetMapping(value = "/getAll" , produces = {"application/json"})
	public ResponseEntity<List<ProfileTab>> getAll() {
		List<ProfileTab> profileLst = profileTabService.getProfile();
		return new ResponseEntity<>(profileLst,
				(profileLst != null && profileLst.size() > 0) ? HttpStatus.OK : HttpStatus.NO_CONTENT);

	}
}
