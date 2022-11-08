FROM cr.loongnix.cn/library/golang:1.19 as build

WORKDIR /go/src/sigs.k8s.io/metrics-server
COPY go.mod .
COPY go.sum .
#RUN go mod download
COPY vendor vendor
COPY pkg pkg
COPY cmd cmd
COPY Makefile Makefile

ARG ARCH
ARG GIT_COMMIT
ARG GIT_TAG
ARG BUILD_DATE
RUN make metrics-server

FROM cr.loongnix.cn/library/debian:buster-slim
COPY --from=build /go/src/sigs.k8s.io/metrics-server/metrics-server /
USER 65534
ENTRYPOINT ["/metrics-server"]
