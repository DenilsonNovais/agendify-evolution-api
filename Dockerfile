FROM atendai/evolution-api:v2.0.10

EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/instance/fetchInstances || exit 1
