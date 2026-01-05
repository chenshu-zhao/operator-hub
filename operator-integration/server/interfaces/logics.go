package interfaces

import (
	"context"
	"io"
)

// Validator 验证接口
// 用于验证算子名称、描述、单次导入个数、导入数据大小等
//
//go:generate mockgen -source=logics.go -destination=../mocks/logics.go -package=mocks
type Validator interface {
	ValidateOperatorName(ctx context.Context, name string) (err error)
	ValidateOperatorDesc(ctx context.Context, desc string) (err error)
	ValidateOperatorImportCount(ctx context.Context, count int64) (err error)
	ValidateOperatorImportSize(ctx context.Context, size int64) (err error)
	ValidatorToolBoxName(ctx context.Context, name string) (err error)
	ValidatorToolBoxDesc(ctx context.Context, desc string) (err error)
	ValidatorToolName(ctx context.Context, name string) (err error)
	ValidatorToolDesc(ctx context.Context, desc string) (err error)
	ValidatorIntCompVersion(ctx context.Context, version string) (err error)
	ValidatorMCPName(ctx context.Context, name string) (err error)
	ValidatorMCPDesc(ctx context.Context, desc string) (err error)
	ValidatorCategoryName(ctx context.Context, name string) (err error)
	ValidatorStruct(ctx context.Context, obj interface{}) (err error)
	ValidatorURL(ctx context.Context, url string) (err error)
}

// ProxyHandler 代理处理器
type ProxyHandler interface {
	HandlerRequest(ctx context.Context, req *HTTPRequest) (resp *HTTPResponse, err error)
}

// IOutboxMessageEvent 消息事件管理
type IOutboxMessageEvent interface {
	Publish(ctx context.Context, req *OutboxMessageReq) (err error)
}

// Forwarder 转发器接口
type Forwarder interface {
	Forward(ctx context.Context, req *HTTPRequest) (*HTTPResponse, error)
	ForwardStream(ctx context.Context, req *HTTPRequest) (*HTTPResponse, error)
}

// StreamProcessor 流式处理器接口
type StreamProcessor interface {
	ProcessSSE(ctx context.Context, reader io.Reader, writer io.Writer) error
	ProcessHTTPStream(ctx context.Context, reader io.Reader, writer io.Writer) error
}

// FunctionExecReq 函数执行请求
type FunctionExecReq struct {
	UserID        string         `header:"user_id"`
	ComponentType ComponentType  `uri:"component_type" validate:"required,oneof=operator toolbox"` // 资源类型
	ComponentID   string         `uri:"component_id" validate:"required"`                          // 资源ID
	ToolID        string         `uri:"tool_id,omitempty"`                                         // 工具ID（仅资源类型为toolbox时使用）
	Version       string         `uri:"version,omitempty"`                                         // 版本号（仅资源类型为operator时使用）
	Event         map[string]any `json:"event" validate:"required"`                                // 事件参数
}

// FunctionExecResp 函数执行响应
// type FunctionExecResp struct {
// 	Stdout  string         `json:"stdout"`  // 标准输出
// 	Stderr  string         `json:"stderr"`  // 标准错误输出
// 	Result  any            `json:"result"`  // 执行结果
// 	Metrics map[string]any `json:"metrics"` // 执行指标
// }

// // FunctionSandBoxExec 函数执行
// type FunctionSandBoxExec interface {
// 	FunctionSandBoxExec(ctx context.Context, req *FunctionExecReq) (resp *FunctionExecResp, err error)
// }

// UnifiedProxyReq 统一代理请求参数
type UnifiedProxyReq struct {
	UserID            string           `header:"user_id" validate:"required"`                            // 用户ID
	ComponentType     ComponentType    `uri:"component_type" validate:"required,oneof=operator toolbox"` // 资源类型
	ComponentID       string           `uri:"component_id" validate:"required"`                          // 资源ID
	ToolID            string           `uri:"tool_id,omitempty"`                                         // 工具ID（仅资源类型为toolbox时使用）
	Version           string           `json:"version,omitempty"`                                        // 版本号（仅资源类型为operator时使用）
	Timeout           int              `json:"timeout,omitempty"`                                        // 超时时间，单位秒
	HTTPRequestParams `json:",inline"` // HTTP请求参数
}

// UnifiedProxyManager  统一代理管理器
// type UnifiedProxyManager interface {
// 	// ExecuteProxy 执行代理请求
// 	ExecuteProxy(ctx context.Context, req *UnifiedProxyReq) (resp *HTTPResponse, err error)
// }
