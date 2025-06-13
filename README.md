奇安信X实验室提供的mcp工具。

# 奇安信X实验室
X实验室（XLab）是奇安信公司致力于大网安全研究、威胁分析溯源和大规模多维度安全数据平台建设的团队。
X实验室是国内最早利用大规模数据进行安全研究、安全应用和威胁情报生产的团队，建立了国内首个PassiveDNS系统，以及多个业内领先的 Netflow、Whois、证书、IP 和恶意样本等基础数据系统。

# 工具分类

目前提供的工具有**网络安全基础数据查询**

# 运行方式
本应用是一个代理程序，可以将对远端mcp工具的调用转换成本地的Stdio运行的方式。
所以运行方式就可以分为本地运行和直接访问远端mcp工具的url运行。

这里需要注意的是远端的mcp server地址目前只支持Streamable HTTP的访问方式。

### Installing via Smithery

To install QAX XLab Security Data Query Server for Claude Desktop automatically via [Smithery](https://smithery.ai/server/@qax-xlab/fdp-mcp-server):

```bash
npx -y @smithery/cli install @qax-xlab/fdp-mcp-server --client claude
```

## 本地代码运行
1. 从仓库客隆代码
2. 使用uv运行，配置claude desktop：
    ```json
    {
        "mcpServers": {
            "fdp-mcp-server": {
                "command": "uv",
                "args": [
                    "run",
                    "--project",
                    "/PATH/TO/fdp-mcp-server",
                    "fdp-mcp-server",
                    "--url",
                    "https://fdp.qianxin.com/mcp/v1/basic/mcp/`"
                ]
            }
        }
    }
    ```

## 本地运行pypi包
使用uvx，配置claude desktop:
```json
{
    "mcpServers": {
        "fdp-mcp-server": {
            "command": "uvx",
            "args": [
                "fdp-mcp-server",
                "--url",
                "https://fdp.qianxin.com/mcp/v1/basic/mcp/`"
            ]
        }
    }
}
```

## 远端mcp服务运行
如果想在智能体应用中调用fdp-mcp-server工具，可以在客户端上配置远端mcp server的url地址直接调用工具。

以smolagents工具为例：
```python
from smolagents import ToolCollection
from smolagents.agents import ToolCallingAgent
from smolagents.models import OpenAIServerModel


def main():
    with ToolCollection.from_mcp(
        {
            "url": "https://fdp.qianxin.com/mcp/v1/basic/mcp/",
            "transport": "streamable-http"
        },
        trust_remote_code=True,
    ) as tools:
        agent = ToolCallingAgent(
            tools=[*tools.tools],
            model=OpenAIServerModel(
                model_id="YOUR-LLM-MODEL-ID",
                api_base="YOUR-LLM-MODEL-API-URL",
                api_key="YOUR-LLM-MODEL-API-KEY",
            ),
        )
        agent.run("查询www.example.com的注册信息，并给做一个简短的总结。")

if __name__ == "__main__":
    main()

```
