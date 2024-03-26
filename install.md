# Install
## 安装Mill
```bash
sudo sh -c "curl -L https://github.com/com-lihaoyi/mill/releases/download/0.10.0/0.10.0 > /usr/local/bin/mill && chmod +x /usr/local/bin/mill"
```
## 编译修改版的NutShell
```bash
make emuverilog CORE=embedded DATAWIDTH=32
```