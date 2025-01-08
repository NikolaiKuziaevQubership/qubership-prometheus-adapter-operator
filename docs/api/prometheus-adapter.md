# PrometheusAdapter API Docs

This Document documents the types introduced by the Prometheus Adapter Operator to be consumed by users.

> Note this document is generated from code comments.
> When contributing a change to this document please do so by changing the code comments.

## Table of Contents

* [PrometheusAdapter API Docs](#prometheusadapter-api-docs)
  * [Table of Contents](#table-of-contents)
  * [PrometheusAdapter](#prometheusadapter)
  * [PrometheusAdapterList](#prometheusadapterlist)
  * [PrometheusAdapterSpec](#prometheusadapterspec)
  * [SecurityContext](#securitycontext)
  * [TLSConfig](#tlsconfig)
  * [Auth](#auth)

## PrometheusAdapter

PrometheusAdapter is the Schema for the prometheusadapters API

| Field | Description | Scheme | Required |
| ----- | ----------- | ------ | -------- |
| metadata |  | [metav1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#objectmeta-v1-meta) | false |
| spec |  | [PrometheusAdapterSpec](#prometheusadapterspec) | false |
| status |  | PrometheusAdapterStatus | false |

[Back to TOC](#table-of-contents)

## PrometheusAdapterList

PrometheusAdapterList contains a list of PrometheusAdapter

| Field | Description | Scheme | Required |
| ----- | ----------- | ------ | -------- |
| metadata |  | [metav1.ListMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#listmeta-v1-meta) | false |
| items |  | []PrometheusAdapter | true |

[Back to TOC](#table-of-contents)

## PrometheusAdapterSpec

PrometheusAdapterSpec defines the desired state of PrometheusAdapter

| Field                          | Description                                                                                                                                                                                                            | Scheme                                                                                                                       | Required |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|----------|
| image                          | Image to use for a `prometheus-adapter` deployment.                                                                                                                                                                    | string                                                                                                                       | true     |
| prometheusUrl                  | PrometheusURL used to connect to Prometheus. It will eventually contain query parameters to configure the connection.                                                                                                  | string                                                                                                                       | false    |
| metricsRelistInterval          | MetricsRelistInterval is the interval at which to update the cache of available metrics from Prometheus                                                                                                                | string                                                                                                                       | false    |
| enableResourceMetrics          | Enable adapter for `metrics.k8s.io`. By default - `false`                                                                                                                                                              | boolean                                                                                                                      | false    |
| customScaleMetricRulesSelector | CustomScaleMetricRulesSelector defines label selectors to select CustomScaleMetricRule resources across the cluster.                                                                                                   | []*[metav1.LabelSelector](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#labelselector-v1-meta)        | false    |
| resources                      | Resources defines resources requests and limits for single Pods.                                                                                                                                                       | [v1.ResourceRequirements](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#resourcerequirements-v1-core) | false    |
| securityContext                | SecurityContext holds pod-level security attributes.                                                                                                                                                                   | *[SecurityContext](#securitycontext)                                                                                         | false    |
| tolerations                    | Tolerations allow the pods to schedule onto nodes with matching taints.                                                                                                                                                | []v1.Toleration                                                                                                              | false    |
| nodeSelector                   | NodeSelector defines which nodes the pods are scheduled on. Specified just as map[string]string. For example: \"type: compute\"                                                                                        | map[string]string                                                                                                            | false    |
| annotations                    | Map of string keys and values stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. Specified just as map[string]string. For example: "annotations-key: annotation-value" | map[string]string                                                                                                            | false    |
| labels                         | Map of string keys and values that can be used to organize and categorize (scope and select) objects. Specified just as map[string]string. For example: "label-key: label-value"                                       | map[string]string                                                                                                            | false    |
| priorityClassName              | PriorityClassName assigned to the Pods to prevent them from evicting.                                                                                                                                                  | string                                                                                                                       | false    |
| tlsEnabled                      | TLS configuration is enabled/disabled. By default, it is disabled.                                                                                                                                                          | boolean                                                                                                     | false    |
| tlsConfig                      | Allow to specify client TLS configuration                                                                                                                                                           | *TLSConfig                                                                                                     | false    |
| auth                           | Client credentials to connect to Prometheus or Victoriametrics endpoints. (Only basic authentication is supported)                                                                                                     | *[Auth](#auth)                                                                                                               | false    |

[Back to TOC](#table-of-contents)

## SecurityContext

SecurityContext holds pod-level security attributes.
The parameters are required if a Pod Security Policy is enabled for Kubernetes cluster and
required if a Security Context Constraints is enabled for Openshift cluster.

| Field | Description | Scheme | Required |
| ----- | ----------- | ------ | -------- |
| runAsUser | The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. | *int64 | false |
| fsGroup | A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:\n\n1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw  | *int64 | false |

[Back to TOC](#table-of-contents)

## TLSConfig

TLSConfig holds SSL/TLS configuration attributes.
The parameters are required if SSL/TLS connection is required between Kubernetes cluster and qubership-prometheus-adapter-operator.
This section is applicable only if `tlsEnabled` is set to `true`.

| Parameter                            | Type    | Mandatory | Default value                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ------------------------------------ | ------- | --------- | ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `caSecret`                     | *v1.SecretKeySelector  | no        | `-`                           | Secret containing the CA certificate to use for the targets.                                                                                                                                                      |
| `certSecret`                   | *v1.SecretKeySelector  | no        | `-`                           | Secret containing the client certificate file for the targets.                                                                                                                                                      |
| `keySecret`                    | *v1.SecretKeySelector  | no        | `-`                           | Secret containing the client key file for the targets.                                                                                                                                                      |
| `existingSecret`                     | string  | no        | `-`                           | Name of the pre-existing secret that contains TLS configuration for prometheus-adapter. If specified, `generateCerts.enabled` must be set to `false`. The `existingSecret` is expected to contain CA certificate, TLS key and TLS certificate in `ca.crt`, `tls.key` and `tls.crt` fields respectively. Use either `existingSecret` or the combination of `caSecret`, `certSecret` and `keySecret`. Do not use it together.                                                                                                                                                     |
| `generateCerts.enabled`              | boolean | no        | `true`                        | Generation of certificate is enabled by default. If `tlsConfig.existingSecret` or the combination of `tlsConfig.caSecret`, `tlsConfig.certSecret` and `tlsConfig.keySecret` is specified, `tlsConfig.generateCerts` section will be skipped. `cert-manager` will generate certificate with the name configured using `generateCerts.secretName`, if it doesn't exist already. |
| `generateCerts.clusterIssuerName`    | string  | no        | `-`                           | Cluster issuer name for generated certificate. This is a mandatory field if `generateCerts.enabled` is set to `true`.                                                                                                                                                                                                                                                                       |
| `generateCerts.duration`             | integer | no        | `365`                         | Duration in days, until which issued certificate will be valid.                                                                                                                                                                                                                                                                                                                                                                                            |
| `generateCerts.renewBefore`          | integer | no        | `15`                          | Number of days before which certificate must be renewed.                                                                                                                                                                                                                                                                                                                                                                                                   |
| `generateCerts.secretName`          | string | no        | `prometheus-adapter-client-tls-secret`                          | Name of the new secret that needs to be created for storing TLS configuration of prometheus-adapter.                                                                                                                                                                                                                                        |
| `createSecret`                       | object  | no        | `-`                           | New secret with the name `tlsConfig.createSecret.secretName` will be created using already known certificate content. If `tlsConfig.existingSecret` or the combination of `tlsConfig.caSecret`, `tlsConfig.certSecret` and `tlsConfig.keySecret` is specified, `tlsConfig.createSecret` section will be skipped.                                                                                                                                                                                                                                                  |
| `createSecret.ca`                    | string  | no        | `-`                           | Already known CA certificate will be added to newly created secret.                                                                                                                                                                                                                                                                                                                                                                                        |
| `createSecret.key`                   | string  | no        | `-`                           | Already known TLS key will be added to newly created secret.                                                                                                                                                                                                                                                                                                                                                                                               |
| `createSecret.cert`                  | string  | no        | `-`                           | Already known TLS certificate will be added to newly created secret.                                                                                                                                                                                                                                                                                                                                                                                       |
| `createSecret.secretName`                  | string  | no        | `prometheus-adapter-client-tls-secret`                           | Already known TLS certificate will be added to newly created secret.                                                                                                                                                                                                                                  |

[Back to TOC](#table-of-contents)

## Auth

Auth holds authentication configuration attributes.
The parameters are required if connection between Prometheus adapter in Kubernetes and Victoriametrics requires authentication.

| Field | Description | Scheme | Required |
| ----- | ----------- | ------ | -------- |
| basicAuth | BasicAuth allow an endpoint to authenticate over basic authentication. | *v1.SecretKeySelector | false |

[Back to TOC](#table-of-contents)
