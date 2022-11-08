### 1. 源码适配
与架构相关代码就一行，适配简单，具体查看：   
> git show 82e43f952a8056d7653eec75d7808fd1921f32f9   
### 2.镜像构建步骤   
使用go1.19构建   
> go env -w GOPROXY=http://goproxy.loongnix.cn:3000   
> rm -rf go.sum   
> go mod tidy   
> go mod vendor   
> REGISTRY=cr.loongnix.cn/k8s-staging-metrics-server ARCH=loong64 GIT_COMMIT=v0.4.2 make container   
