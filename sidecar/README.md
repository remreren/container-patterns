# Sidecar Pattern Demo

This example illustrates the sidecar container pattern, keeping the core app slim while outsourcing cross-cutting concerns to a dedicated sidecar (OpenTelemetry collector in this case).

## Layout
- `app/` minimal FastAPI service plus Dockerfile and entrypoint for local runs.
- `k8s/` Kubernetes manifests wiring the app pod, service, namespace, and OpenTelemetry collector sidecar.

## Try It
1. Build the app image: `docker build -t sidecar-app app/`.
2. Deploy to a cluster: `kubectl apply -f k8s/`.
3. Watch the combined pod: `kubectl get pods -n sidecar-demo`.
4. Forward app traffic to your workstation: `kubectl port-forward svc/example-sidecar-app 8000:8000 -n sidecar-demo`.
5. Forward grafana traffic to your workstation: `kubectl port-forward svc/otel-lgtm 3000:3000 -n sidecar-demo`.
6. Call the dice endpoint: `curl localhost:8000/roll` (returns a random 1-6 result).
7. Traces and metrics should appear in the OTEL demo stack Grafana at `http://localhost:3000` (default user/pass: `admin/admin`).

## Notes
- The `otel-sidecar-config.yml` file routes traces and metrics to the OTEL demo stack under `k8s/otel-lgtm.yml`.
- Adjust image names and namespaces to fit your environment before pushing to a shared registry.
