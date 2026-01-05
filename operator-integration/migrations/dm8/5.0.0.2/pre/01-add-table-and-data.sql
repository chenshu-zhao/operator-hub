SET SCHEMA dip_data_operator_hub;

CREATE TABLE IF NOT EXISTS "t_mcp_tool" (
    "f_id" BIGINT IDENTITY(1, 1) NOT NULL,
    "f_mcp_tool_id" VARCHAR(40 CHAR) NOT NULL,
    "f_mcp_id" VARCHAR(40 CHAR) NOT NULL,
    "f_mcp_version" INT NOT NULL,
    "f_box_id" VARCHAR(40 CHAR) NOT NULL,
    "f_box_name" VARCHAR(50 CHAR),
    "f_tool_id" VARCHAR(40 CHAR) NOT NULL,
    "f_name" VARCHAR(256 CHAR),
    "f_description" text,
    "f_use_rule" text,
    "f_create_user" VARCHAR(50 CHAR) NOT NULL,
    "f_create_time" BIGINT NOT NULL,
    "f_update_user" VARCHAR(50 CHAR) NOT NULL,
    "f_update_time" BIGINT NOT NULL,
    CLUSTER PRIMARY KEY ("f_id")
);

CREATE UNIQUE INDEX IF NOT EXISTS t_mcp_tool_uk_mcp_tool_id ON t_mcp_tool(f_mcp_tool_id);
CREATE INDEX IF NOT EXISTS t_mcp_tool_idx_mcp_id_version ON t_mcp_tool(f_mcp_id, f_mcp_version);
CREATE INDEX IF NOT EXISTS t_mcp_tool_idx_name_update ON t_mcp_tool(f_name, f_update_time);

