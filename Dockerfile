FROM iron/go:dev as builder
WORKDIR /go/src/github.com/vapor-ware/synse-amt-plugin
COPY . .
RUN make build GIT_TAG="" GIT_COMMIT=""


FROM iron/go
LABEL maintainer="vapor@vapor.io"

WORKDIR /plugin

COPY --from=builder /go/src/github.com/vapor-ware/synse-amt-plugin/build/plugin ./plugin
COPY config.yml .
COPY config/proto /etc/synse/plugin/config/proto

CMD ["./plugin"]