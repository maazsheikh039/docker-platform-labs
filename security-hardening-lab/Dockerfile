# Stage 1: Build stage (Assemble artifacts)
FROM ubuntu:22.04 AS builder
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && echo "Build artifact generated securely" > /app-artifact.txt

# Stage 2: Production hardened stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates \
    && addgroup -g 1001 appgroup \
    && adduser -u 1001 -G appgroup -S appuser

WORKDIR /home/appuser
COPY --from=builder /app-artifact.txt /home/appuser/app-artifact.txt
RUN chown -R appuser:appgroup /home/appuser

USER 1001

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --spider http://localhost:8080/ || exit 1

CMD ["sh", "-c", "echo 'Secure Application Running...' && tail -f /dev/null"]
