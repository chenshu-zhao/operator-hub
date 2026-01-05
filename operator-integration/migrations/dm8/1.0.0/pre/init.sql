SET SCHEMA dip_data_operator_hub;

CREATE TABLE IF NOT EXISTS "t_metadata_api" (
    "f_id" BIGINT IDENTITY(1, 1) NOT NULL,
    "f_summary" VARCHAR(256 CHAR) NOT NULL, 
    "f_version" VARCHAR(40 CHAR) NOT NULL,
    "f_svc_url" text NOT NULL,  
    "f_description" text, 
    "f_path" text NOT NULL,
    "f_method" VARCHAR(50 CHAR) NOT NULL,
    "f_api_spec" text DEFAULT NULL,
    "f_create_user" VARCHAR(50 CHAR) NOT NULL,
    "f_update_user" VARCHAR(50 CHAR) NOT NULL,
    "f_create_time" BIGINT NOT NULL,
    "f_update_time" BIGINT NOT NULL,
    CLUSTER PRIMARY KEY ("f_id")
);

CREATE INDEX IF NOT EXISTS t_metadata_api_idx_version_update ON t_metadata_api(f_version, f_update_time);



CREATE TABLE IF NOT EXISTS "t_op_registry" (
    "f_id" BIGINT IDENTITY(1, 1) NOT NULL,
    "f_op_id" VARCHAR(40 CHAR) NOT NULL,
    "f_name" VARCHAR(512 CHAR) NOT NULL, 
    "f_metadata_version" VARCHAR(40 CHAR) NOT NULL,
    "f_is_latest" TINYINT  DEFAULT 0, 
    "f_metadata_type" VARCHAR(40 CHAR) NOT NULL,
    "f_status" VARCHAR(10 CHAR) DEFAULT 0,
    "f_operator_type" VARCHAR(10 CHAR) DEFAULT 0,
    "f_execution_mode" VARCHAR(10 CHAR) DEFAULT 0,
    "f_category" VARCHAR(50 CHAR) DEFAULT 0,
    "f_source" VARCHAR(50 CHAR) DEFAULT '',
    "f_execute_control" text DEFAULT NULL, 
    "f_extend_info" text DEFAULT NULL,  
    "f_create_user" VARCHAR(50 CHAR) NOT NULL,
    "f_create_time" BIGINT NOT NULL,
    "f_update_user" VARCHAR(50 CHAR) NOT NULL,
    "f_update_time" BIGINT NOT NULL,
    "f_is_deleted" TINYINT DEFAULT 0, 
    CLUSTER PRIMARY KEY ("f_id")
);

CREATE UNIQUE INDEX IF NOT EXISTS t_op_registry_uk_op_id_version ON t_op_registry(f_op_id, f_metadata_version);
CREATE INDEX IF NOT EXISTS t_op_registry_idx_name_update ON t_op_registry(f_name, f_update_time);
CREATE INDEX IF NOT EXISTS t_op_registry_idx_status_update ON t_op_registry(f_status, f_update_time);
CREATE INDEX IF NOT EXISTS t_op_registry_idx_category_update ON t_op_registry(f_category, f_update_time);
CREATE INDEX IF NOT EXISTS t_op_registry_idx_create_user_update ON t_op_registry(f_create_user, f_update_time);
CREATE INDEX IF NOT EXISTS t_op_registry_idx_update_time ON t_op_registry(f_update_time);

