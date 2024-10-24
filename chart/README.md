## Prerequisites

- Kubernetes 1.19+
- Helm 3+
- Access to a container registry that hosts `arcadedata/arcadedb` Docker image

## Installation

### Install the Chart
To install the chart with the release name my-arcadedb:

```console
helm install my-arcadedb oci://ghcr.io/fntsoftware/helm/arcadedb
```
This command will install ArcadeDB using the default values. To customize the installation, refer to the Configuration section.

### Upgrading the Chart
To upgrade an existing release:

```console
helm upgrade my-arcadedb oci://ghcr.io/fntsoftware/helm/arcadedb
```
### Uninstallation
To uninstall the my-arcadedb release:

```console
helm uninstall my-arcadedb
```
<!---helm_readme-->
## Configuration

The following table lists the configurable parameters of the ArcadeDB chart and their default values:

| Key                                                                                                                                | Default-Value              | Description                                                                                   | Possible-Value                                                                                                                          |
| ---------------------------------------------------------------------------------------------------------------------------------- | -------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `credentials.rootPassword`                                                                                                         | `SuperPass`                | Root password for the ArcadeDB server                                                         | String                                                                                                                                  |
| `replicas`                                                                                                                         | `1`                        | Number of replicas for high availability                                                      | Number                                                                                                                                  |
| `image.registry`                                                                                                                   | `docker.io`                | Docker image registry                                                                         | -                                                                                                                                       |
| `image.repository`                                                                                                                 | `arcadedata/arcadedb`      | Docker image repository                                                                       | -                                                                                                                                       |
| `image.tag`                                                                                                                        | `24.10.1`                  | ArcadeDB Docker image tag                                                                     | A valid image tag                                                                                                                       |
| `image.pullPolicy`                                                                                                                 | `IfNotPresent`             | Image pull policy                                                                             | [ImagePullPolicy](https://kubernetes.io/docs/concepts/configuration/overview/#container-images)                                         |
| `service.httpPort`                                                                                                                 | `2480`                     | HTTP service port                                                                             |                                                                                                                                         |
| `service.rpcPort`                                                                                                                  | `2424`                     | RPC service port                                                                              |                                                                                                                                         |
| `service.gremlinPort`                                                                                                              | `8182`                     | Gremlin service port                                                                          |                                                                                                                                         |
| `resources.requests.memory`                                                                                                        | `512Mi`                    | Memory request for the container                                                              |                                                                                                                                         |
| `resources.limits.memory`                                                                                                          | `1Gi`                      | Memory limit for the container                                                                |                                                                                                                                         |
| `pvc.size`                                                                                                                         | `10Gi`                     | Persistent Volume Claim size                                                                  |                                                                                                                                         |
| `podSecurityContext.fsGroup`                                                                                                       | `1000`                     | Security context for the pod                                                                  | -                                                                                                                                       |
| `affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.weight`                                                  | `100`                      | Sets the anti-affinity preference with the highest weight                                     | [affinity and anti affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity)             |
| `affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.podAffinityTerm.labelSelector.matchExpressions.key`      | `app`                      | Specifies the label key to identify arcadedb pods for anti-affinity                           | [affinity and anti affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity)             |
| `affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.podAffinityTerm.labelSelector.matchExpressions.operator` | `In`                       | Sets the operator                                                                             | [affinity and anti affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity)             |
| `affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.podAffinityTerm.labelSelector.matchExpressions.values`   | `arcadedb`                 | Specifies the label value                                                                     | [affinity and anti affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity)             |
| `affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.podAffinityTerm.topologyKey`                             | `kubernetes.io/hostname`   | Distributes arcadedb pods across different nodes by using hostname as the topology key        | [affinity and anti affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity)             |
| `readinessProbe.httpGet.path`                                                                                                      | `/api/v1/ready`            | Specifies the HTTP endpoint to check for readiness                                            | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `readinessProbe.httpGet.port`                                                                                                      | `http`                     | Defines the port on which the readiness probe will make the request                           | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `readinessProbe.initialDelaySeconds`                                                                                               | `30`                       | Sets the initial delay before the readiness probe starts checking the endpoint                | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `readinessProbe.periodSeconds`                                                                                                     | `10`                       | Configures the probe run intervals                                                            | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `readinessProbe.timeoutSeconds`                                                                                                    | `5`                        | Sets response waiting time from the readiness endpoint before considering the probe failed    | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `readinessProbe.successThreshold`                                                                                                  | `1`                        | Required number of successful check to consider the container ready                           | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `readinessProbe.failureThreshold`                                                                                                  | `6`                        | Defines the number of consecutive failed probes before the container is considered not ready  | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `livenessProbe.httpGet.path`                                                                                                       | `/api/v1/ready`            | Specifies the HTTP endpoint to check for liveness                                             | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `livenessProbe.httpGet.port`                                                                                                       | `http`                     | Defines the port on which the liveness probe will make the request                            | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `livenessProbe.initialDelaySeconds`                                                                                                | `180`                      | Sets the initial delay before the liveness probe starts checking the endpoint                 | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `livenessProbe.periodSeconds`                                                                                                      | `10`                       | Configures the probe run intervals                                                            | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `livenessProbe.timeoutSeconds`                                                                                                     | `5`                        | Sets response waiting time from the liveness endpoint before considering the probe failed     | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `livenessProbe.successThreshold`                                                                                                   | `1`                        | Required number of successful check to consider the container alive                           | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |
| `livenessProbe.failureThreshold`                                                                                                   | `6`                        | Defines the number of consecutive failed probes before the container is considered unhealthy  | [liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes)   |                                                                          |
| `podManagementPolicy`                                                                                                              | `OrderedReady`             | Policy for pod management in StatefulSet                                                      | -                                                                                                                                       |
| `updateStrategy.type`                                                                                                              | `RollingUpdate`            | Update strategy for StatefulSet                                                               | RollingUpdate,Recreate                                                                                                                  |

<!---/helm_readme-->


To modify these parameters, you can specify each parameter using the `--set` flag, or create a custom `values.yaml` file:

Usage
After installing, you can connect to the ArcadeDB service using the specified ports.

High Availability Configuration
To enable high availability, set the `replicas` parameter to `2` or more and add HA-related parameters in args. For details, check the ArcadeDB High Availability Documentation.

Persistent Data Storage
This chart includes a Persistent Volume Claim (PVC) for data storage at `/mnt/data0`. You can adjust the size by setting `pvc.size` in `values.yaml`.