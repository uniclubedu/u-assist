-- registration_tab

 CREATE TABLE registration_tab (
	user_id INTEGER PRIMARY KEY,
	user_name CHARACTER(35)
);
INSERT INTO registration_tab(user_id,user_name) values (1,'vidya');
INSERT INTO registration_tab(user_id,user_name) values (2,'avinash');
INSERT INTO registration_tab(user_id,user_name) values (3,'viraj');
INSERT INTO registration_tab(user_id,user_name) values (4,'prabha');
INSERT INTO registration_tab(user_id,user_name) values (5,'sunitha');
INSERT INTO registration_tab(user_id,user_name) values (6,'rama');
INSERT INTO registration_tab(user_id,user_name) values (7,'ajay');
INSERT INTO registration_tab(user_id,user_name) values (8,'shashank');
INSERT INTO registration_tab(user_id,user_name) values (9,'pramod');
INSERT INTO registration_tab(user_id,user_name) values (10,'dean');
INSERT INTO registration_tab(user_id,user_name) values (11,'jay');
INSERT INTO registration_tab(user_id,user_name) values (12,'ryan');


-- utilization_tab

 CREATE TABLE utilization_tab (
	user_id INTEGER NOT NULL ,
	util_id INTEGER PRIMARY KEY ,
	storage_free INTEGER ,
	storage_used INTEGER ,
	storage_capacity INTEGER,
	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id)
);
INSERT INTO utilization_tab(user_id,util_id,storage_free,storage_used,storage_capacity) values (1,1,150,100,250);
INSERT INTO utilization_tab(user_id,util_id,storage_free,storage_used,storage_capacity) values (2,2,150,100,250);
INSERT INTO utilization_tab(user_id,util_id,storage_free,storage_used,storage_capacity) values (3,3,150,100,250);


-- geography_tab

 CREATE TABLE geography_tab (
	user_id INTEGER NOT NULL ,
	geo_id INTEGER PRIMARY KEY ,
	geo_location CHARACTER(35) ,
	geo_building CHARACTER(35) ,
	geo_floor CHARACTER(35),
	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id)
);
INSERT INTO geography_tab(user_id,geo_id,geo_location,geo_building,geo_floor) values (1,1,'Adams Boulevard','Building A','12');
INSERT INTO geography_tab(user_id,geo_id,geo_location,geo_building,geo_floor) values (2,2,'Arrow Highway','Building Z','14');
INSERT INTO geography_tab(user_id,geo_id,geo_location,geo_building,geo_floor) values (3,3,'Avalon Boulevard','Building C','7');


-- profile_tab

 CREATE TABLE profile_tab (
	user_id INTEGER NOT NULL ,
	profile_id INTEGER PRIMARY KEY ,
	user_profession CHARACTER(35) ,
	user_phone CHARACTER(35) ,
	user_address CHARACTER(225),
	user_description CHARACTER(225),
	user_email CHARACTER(225),
	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id)
);
INSERT INTO profile_tab(user_id,profile_id,user_profession,user_phone,user_address,user_description,user_email) values (1,1,'Doctor','9999999999','C-12 AdamStreet CA','USER A','a.b@c.com');


-- credentials_tab

 CREATE TABLE credentials_tab (
	user_id INTEGER NOT NULL ,
	cred_id INTEGER PRIMARY KEY ,
	user_expiration INTEGER ,
	user_role CHARACTER(10) ,
	user_last_login INTEGER ,
	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id)
);
INSERT INTO credentials_tab(user_id,cred_id,user_expiration,user_role,user_last_login) values (1,1,12345,'USER',12345);
INSERT INTO credentials_tab(user_id,cred_id,user_expiration,user_role,user_last_login) values (2,2,12245,'ADMIN',12345);
INSERT INTO credentials_tab(user_id,cred_id,user_expiration,user_role,user_last_login) values (3,3,15445,'SUER',12345);



-- quota_tab

 CREATE TABLE quota_tab (
	user_id INTEGER NOT NULL ,
	quota_id INTEGER PRIMARY KEY ,
	user_num_running_jobs INTEGER ,
	user_number_processors INTEGER ,
	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id)
);
INSERT INTO quota_tab(user_id,quota_id,user_num_running_jobs,user_number_processors) values (1,1,22,2);
INSERT INTO quota_tab(user_id,quota_id,user_num_running_jobs,user_number_processors) values (2,2,20,2);
INSERT INTO quota_tab(user_id,quota_id,user_num_running_jobs,user_number_processors) values (3,3,11,3);
INSERT INTO quota_tab(user_id,quota_id,user_num_running_jobs,user_number_processors) values (4,4,8,3);


-- storage_tab

 CREATE TABLE storage_tab (
	user_id INTEGER NOT NULL ,
	storage_uuid INTEGER PRIMARY KEY ,
	storage_encryption_type CHARACTER(10) ,
	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id)
);
INSERT INTO storage_tab(user_id,storage_uuid,storage_encryption_type) values (1,1,'DES');
INSERT INTO storage_tab(user_id,storage_uuid,storage_encryption_type) values (2,2,'AES');
INSERT INTO storage_tab(user_id,storage_uuid,storage_encryption_type) values (3,3,'DES');
INSERT INTO storage_tab(user_id,storage_uuid,storage_encryption_type) values (4,4,'AES');


-- results_tab

 CREATE TABLE results_tab (
	user_id INTEGER NOT NULL ,
	result_id INTEGER PRIMARY KEY ,
	container_id INTEGER ,
	result_location CHARACTER(35) ,
	result_execution_time INTEGER ,
	result_last_run CHARACTER (35) ,
	result_pass BOOLEAN NOT NULL , 
	result_name CHARACTER(35) ,
	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id)
);
INSERT INTO results_tab(user_id,result_id,container_id,result_location,result_execution_time,result_last_run,result_pass,result_name) values (1,1,1,'AdamStreet',12345,'Success',TRUE,'ABC');


-- accelertor_tab

 CREATE TABLE accelertor_tab (
	user_id INTEGER NOT NULL ,
	accelertor_id INTEGER PRIMARY KEY ,
	acc_cpu_intel_atom_processor BOOLEAN NOT NULL ,
	acc_cpu_intel_celeron_processor BOOLEAN NOT NULL ,
	acc_cpu_intel_core_processor BOOLEAN NOT NULL ,
	acc_cpu_intel_pentium_processor BOOLEAN NOT NULL ,
	acc_cpu_intel_xeon_processor BOOLEAN NOT NULL ,
	acc_cpu_intel_xeon_phi_processor BOOLEAN NOT NULL ,
	acc_gpu BOOLEAN NOT NULL ,
 	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id)
);
INSERT INTO accelertor_tab(user_id,accelertor_id,acc_cpu_intel_atom_processor,acc_cpu_intel_celeron_processor,acc_cpu_intel_core_processor,acc_cpu_intel_pentium_processor,acc_cpu_intel_xeon_processor,
acc_cpu_intel_xeon_phi_processor,acc_gpu) values (1,1,TRUE,FALSE,FALSE,FALSE,TRUE,TRUE,TRUE);
INSERT INTO accelertor_tab(user_id,accelertor_id,acc_cpu_intel_atom_processor,acc_cpu_intel_celeron_processor,acc_cpu_intel_core_processor,acc_cpu_intel_pentium_processor,acc_cpu_intel_xeon_processor,
acc_cpu_intel_xeon_phi_processor,acc_gpu) values (2,2,TRUE,FALSE,TRUE,FALSE,TRUE,TRUE,TRUE);
INSERT INTO accelertor_tab(user_id,accelertor_id,acc_cpu_intel_atom_processor,acc_cpu_intel_celeron_processor,acc_cpu_intel_core_processor,acc_cpu_intel_pentium_processor,acc_cpu_intel_xeon_processor,
acc_cpu_intel_xeon_phi_processor,acc_gpu) values (3,3,FALSE,FALSE,TRUE,FALSE,TRUE,TRUE,TRUE);


-- configuration_tab

 CREATE TABLE configuration_tab (
	user_id INTEGER NOT NULL ,
	configuration_id INTEGER PRIMARY KEY ,
	port_values CHARACTER(35) ,
	accelertor_id INTEGER ,
	configuration_name CHARACTER(35) ,
	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id),
	FOREIGN KEY (accelertor_id)
	REFERENCES accelertor_tab (accelertor_id)
);
INSERT INTO configuration_tab(user_id,configuration_id,port_values,accelertor_id,configuration_name) values (1,101,'8080,8081',1,'myConfig1');
INSERT INTO configuration_tab(user_id,configuration_id,port_values,accelertor_id,configuration_name) values (2,102,'8088',2,'myConfig3');
INSERT INTO configuration_tab(user_id,configuration_id,port_values,accelertor_id,configuration_name) values (3,103,'8089',3,'configStart');


-- tag_tab

 CREATE TABLE tag_tab (
	user_id INTEGER NOT NULL ,
	tag_id INTEGER PRIMARY KEY ,
	tag_name CHARACTER(15) ,
	tag_description CHARACTER(225) ,
 	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id)
);
INSERT INTO tag_tab(user_id,tag_id,tag_name,tag_description) values (1,1,'tagVidya','test');
INSERT INTO tag_tab(user_id,tag_id,tag_name,tag_description) values (2,2,'tagAviash','test');
INSERT INTO tag_tab(user_id,tag_id,tag_name,tag_description) values (3,3,'tagTarun','test');
INSERT INTO tag_tab(user_id,tag_id,tag_name,tag_description) values (4,4,'tagJagdish','test');


-- container_tab

 CREATE TABLE container_tab (
	user_id INTEGER NOT NULL ,
	container_id INTEGER PRIMARY KEY ,
	container_name CHARACTER(15) ,
	container_type BOOLEAN NOT NULL ,
	container_description CHARACTER(225) ,
	container_registry_location CHARACTER(35) ,
	tag_id INTEGER ,
 	FOREIGN KEY (user_id)
	REFERENCES registration_tab (user_id),
	FOREIGN KEY (tag_id)
	REFERENCES tag_tab (tag_id)
);
INSERT INTO container_tab(user_id,container_id,container_name,container_type,container_description,container_registry_location,tag_id) values (1,1,'vidya c1',TRUE,'test container','r1',1);
INSERT INTO container_tab(user_id,container_id,container_name,container_type,container_description,container_registry_location,tag_id) values (2,2,'tarun c1',TRUE,'test container','r2',2);
INSERT INTO container_tab(user_id,container_id,container_name,container_type,container_description,container_registry_location,tag_id) values (3,3,'avinash c1',TRUE,'test container','r3',3);