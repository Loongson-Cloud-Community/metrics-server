# Update the base image in Makefile when updating golang version. This has to
# be pre-pulled in order to work on GCB.
FROM cr.loongnix.cn/library/golang:1.19 as build

RUN apt update -y && apt install -y libcap2-bin
WORKDIR /go/src/sigs.k8s.io/metrics-server
COPY go.mod .
COPY go.sum .

COPY vendor vendor
COPY pkg pkg
COPY cmd cmd
COPY Makefile Makefile

ARG ARCH
ARG GIT_COMMIT
ARG GIT_TAG
RUN make metrics-server
RUN setcap cap_net_bind_service=+ep metrics-server

FROM cr.loongnix.cn/library/debian:buster
COPY --from=build /go/src/sigs.k8s.io/metrics-server/metrics-server /
USER 65534
ENTRYPOINT ["/metrics-server"]
