#!/bin/sh

opentelemetry-instrument \
  --service_name=${OTEL_SERVICE_NAME} \
  --resource_attributes=${OTEL_RESOURCE_ATTRIBUTES} \
  --exporter_otlp_endpoint=${OTEL_EXPORTER_OTLP_ENDPOINT} \
  --exporter_otlp_protocol=${OTEL_EXPORTER_OTLP_PROTOCOL} \
  --exporter_otlp_insecure=${OTEL_EXPORTER_OTLP_INSECURE} \
  --traces_exporter=${OTEL_TRACES_EXPORTER} \
  --metrics_exporter=${OTEL_METRICS_EXPORTER} \
  --logs_exporter=${OTEL_LOGS_EXPORTER} \
  --id_generator=${OTEL_PYTHON_ID_GENERATOR} \
  uvicorn main:app --host 0.0.0.0 --port 8000