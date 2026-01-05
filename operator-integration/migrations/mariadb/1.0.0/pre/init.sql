USE dip_data_operator_hub;

CREATE TABLE IF NOT EXISTS `t_metadata_api` (
    `f_id` bigint AUTO_INCREMENT NOT NULL COMMENT '自增主键',
    `f_summary` varchar(256) NOT NULL COMMENT '摘要', -- 接口摘要 (唯一索引)
    `f_version` varchar(40) NOT NULL COMMENT 'UUID',
    `f_svc_url` text NOT NULL COMMENT '算子地址',  -- 编辑后生成新的版本
    `f_description` text COMMENT '算子描述', -- 单个接口描述（详情）
    `f_path` text NOT NULL COMMENT 'API路径',
    `f_method` varchar(50) NOT NULL COMMENT '请求方法',
    `f_api_spec` longtext DEFAULT NULL COMMENT 'API内容',
    `f_create_user` varchar(50) NOT NULL COMMENT '创建者',
    `f_update_user` varchar(50) NOT NULL COMMENT '编辑者',
    `f_create_time` bigint(20) NOT NULL COMMENT '创建时间',
    `f_update_time` bigint(20) NOT NULL COMMENT '编辑时间',
    PRIMARY KEY (`f_id`),
    KEY idx_version_update (f_version, f_update_time) USING BTREE
) ENGINE=InnoDB COMMENT = 'API元数据表';

CREATE TABLE IF NOT EXISTS `t_op_registry` (
    `f_id` bigint AUTO_INCREMENT NOT NULL COMMENT '自增主键',
    `f_op_id` varchar(40) NOT NULL COMMENT '算子ID,UUID',
    `f_name` varchar(512) NOT NULL COMMENT '算子名称', -- 默认为摘要
    `f_metadata_version` varchar(40) NOT NULL COMMENT '算子元数据版本(关联t_metadata_api.f_version)',
    `f_is_latest` boolean DEFAULT 0 COMMENT '是否为最新版本', -- 0: 不是, 1: 是
    `f_metadata_type` varchar(40) NOT NULL COMMENT '算子元数据类型(api/func/...)',
    `f_status` varchar(10) DEFAULT 0 COMMENT '算子状态',
    `f_operator_type` varchar(10) DEFAULT 0 COMMENT '算子类型, 0：基础算子, 1: 组合算子',
    `f_execution_mode` varchar(10) DEFAULT 0 COMMENT '执行模式, 0: 同步执行, 1: 异步执行',
    `f_category` varchar(50) DEFAULT 0 COMMENT '算子业务分类, 数据处理/算法模型',
    `f_source` varchar(50) DEFAULT '' COMMENT '算子来源,system/unknown',
    `f_execute_control` text DEFAULT NULL COMMENT '执行控制参数', -- 超时重试策略
    `f_extend_info` text DEFAULT NULL COMMENT '扩展信息',  -- flow_id一类
    `f_create_user` varchar(50) NOT NULL COMMENT '创建者',
    `f_create_time` bigint(20) NOT NULL COMMENT '创建时间',
    `f_update_user` varchar(50) NOT NULL COMMENT '编辑者',
    `f_update_time` bigint(20) NOT NULL COMMENT '编辑时间',
    `f_is_deleted` boolean DEFAULT 0 COMMENT '是否删除', -- 0: 未删除, 1: 待删除
    PRIMARY KEY (`f_id`),
    UNIQUE KEY uk_op_id_version (f_op_id, f_metadata_version) USING BTREE,
    KEY idx_name_update (f_name, f_update_time) USING BTREE,
    KEY idx_status_update (f_status, f_update_time) USING BTREE,
    KEY idx_category_update (f_category, f_update_time) USING BTREE,
    KEY idx_create_user_update (f_create_user, f_update_time) USING BTREE,
    KEY idx_update_time (f_update_time) USING BTREE
) ENGINE = InnoDB COMMENT = '算子注册表';