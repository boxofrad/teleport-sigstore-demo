FROM alpine

COPY --from=ghcr.io/spiffe/aws-spiffe-workload-helper:latest /ko-app/cmd /aws-spiffe-workload-helper
ADD .aws/config /root/.aws/config
ADD ./build/demo /bin/demo

ENTRYPOINT ["/bin/demo"]
