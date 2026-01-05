
SET SEARCH_PATH TO dip_data_operator_hub;


CREATE TABLE IF NOT EXISTS `t_mcp_tool` (
  `f_id` BIGSERIAL NOT NULL COMMENT '自增主键',
  `f_mcp_tool_id` VARCHAR(40) NOT NULL COMMENT 'mcp_tool_id',
  `f_mcp_id` VARCHAR(40) NOT NULL COMMENT 'mcp_id',
  `f_mcp_version` INT(20) NOT NULL COMMENT 'mcp版本',
  `f_box_id` VARCHAR(40) NOT NULL COMMENT '工具箱ID',
  `f_box_name` VARCHAR(50) COMMENT '工具箱名称',
  `f_tool_id` VARCHAR(40) NOT NULL COMMENT '工具ID',
  `f_name` VARCHAR(256)  COMMENT '工具名称',
  `f_description` LONGTEXT  COMMENT '工具描述',
  `f_use_rule` LONGTEXT  COMMENT '使用规则',
  `f_create_user` VARCHAR(50) NOT NULL COMMENT '创建者',
  `f_create_time` BIGINT(20) NOT NULL COMMENT '创建时间',
  `f_update_user` VARCHAR(50) NOT NULL COMMENT '编辑者',
  `f_update_time` BIGINT(20) NOT NULL COMMENT '编辑时间',
  PRIMARY KEY (`f_id`),
  UNIQUE KEY `idx_t_mcp_tool_uk_mcp_tool_id` (f_mcp_tool_id)
);

CREATE INDEX IF NOT EXISTS `idx_t_mcp_tool_idx_mcp_id_version` ON `t_mcp_tool` (f_mcp_id, f_mcp_version);
CREATE INDEX IF NOT EXISTS `idx_t_mcp_tool_idx_name_update` ON `t_mcp_tool` (f_name, f_update_time);

