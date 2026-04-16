# 🚀 Platform Engineer: The Cloud-Native Blueprint

This repository is a professional **Internal Developer Platform (IDP)** demonstration. It showcases a production-ready Nginx deployment secured with fine-grained RBAC, automated scaling, and eBPF-powered network isolation.

---

## 📖 Table of Contents
1. [📦 Internal Developer Platform (Backstage)](#-internal-developer-platform-backstage)
2. [🔄 GitOps & Continuous Delivery (ArgoCD)](#-gitops--continuous-delivery-argocd)
3. [🛡️ DevSecOps & Security (CI/CD)](#-devsecops--security-cicd)
4. [🏗️ Infrastructure as Code (Terraform & LocalStack)](#-infrastructure-as-code-terraform--localstack)
5. [🌐 Networking & Observability (Cilium & Hubble)](#-networking--observability-cilium--hubble)
6. [📊 Monitoring & Metrics (Prometheus & Grafana)](#-monitoring--metrics-prometheus--grafana)
7. [🔑 Secrets Management (Sealed Secrets)](#-secrets-management-sealed-secrets)
8. [🚀 Apps & Base Implementation](#-apps--base-implementation)
9. [🚦 Local Access & Requirements](#-local-access--requirements)
10. [📂 Repository Structure](#-repository-structure)
11. [🔮 Future Improvements](#-future-improvements)

---

## 📦 Internal Developer Platform (Backstage)
* **Backstage.io:** Acts as the unified software catalog and developer portal.
* **Service Scaffolding:** Provides templates for developers to spin up new services with pre-configured infrastructure and CI/CD.

## 🔄 GitOps & Continuous Delivery (ArgoCD)
* **App-of-Apps Pattern:** A single Root-App in the `/bootstrap` folder orchestrates the entire cluster state.
* **Kustomization:** Uses `kustomization.yaml` to automatically inject `env: production` labels and `prod-` prefixes across all resources, ensuring consistent environment management.

## 🛡️ DevSecOps & Security (CI/CD)
* **Hardened Images:** Uses `nginx-unprivileged:stable-alpine` to prevent root-access vulnerabilities.
* **Security Scanning:** CI/CD integration with **Trivy** (Images), **Checkov** (IaC), and **Semgrep** (SAST).
* **RBAC:** Implements a `junior-dev-sa` ServiceAccount with a restricted `pod-reader` Role to enforce the Principle of Least Privilege.

## 🏗️ Infrastructure as Code (Terraform & LocalStack)
* **Terraform:** Used for cloud resource provisioning with modular code.
* **LocalStack:** Full AWS emulation for local testing of Terraform scripts, allowing for rapid iteration without cloud costs.

## 🌐 Networking & Observability (Cilium & Hubble)
* **Cilium:** eBPF-powered networking, security, and load balancing.
* **Hubble:** Real-time visualization of network flows and service dependencies.
* **Network Policies:** * **Egress Control:** Restricts Nginx traffic only to Redis (Port 6379) and DNS.
    * **Ingress Control:** Allows traffic only from the `monitoring` namespace for metrics scraping.

## 📊 Monitoring & Metrics (Prometheus & Grafana)
* **Horizontal Pod Autoscaler (HPA):** Automatically scales Nginx replicas (min: 2, max: 10) based on a 70% CPU utilization threshold.
* **Observability:** Pre-configured Grafana dashboards for visualizing platform health.

## 🔑 Secrets Management (Sealed Secrets)
* **Sealed Secrets:** Encrypts sensitive data into Git-safe objects that can only be decrypted by the controller within the Kubernetes cluster.

## 🚀 Apps & Base Implementation
The `/apps/base` directory contains the core application manifests:
* **Deployment:** Nginx running on a non-privileged port (8080) with a hardened `securityContext`. 
* **Volume Management:** Uses `emptyDir` volumes for `/var/cache/nginx`, `/var/run`, and `/tmp` to resolve permission issues in restricted environments.
* **Service:** A `ClusterIP` service mapping traffic to the unprivileged container port.

## 🚦 Local Access & Requirements
### Prerequisites
* **Docker Desktop:** This is required to run the local container runtime and the Kubernetes cluster.

### Access Points
* **ArgoCD UI:** `http://argocd.local`
* **Grafana:** `http://grafana.local`
* **Hubble UI:** `http://hubble.local`

> [!IMPORTANT]
> Ensure your `/etc/hosts` file is updated to map these domains to your local cluster entry point.

## 📂 Repository Structure
| Directory | Description |
| :--- | :--- |
| **`.github/workflows`** | CI/CD pipelines & Security Scans (Trivy, Checkov, Semgrep) |
| **`apps/base`** | Hardened Nginx manifests, RBAC, HPA, and Network Policies |
| **`bootstrap`** | ArgoCD Root-App (The platform's entry point) |
| **`infrastructure`** | Platform-wide services (Cilium, Monitoring, Ingress) |
| **`terraform`** | IaC modules and LocalStack testing setup |

## 🔮 Future Improvements
* **Automated Cluster Bootstrapping:** Future versions will support direct deployment on **K3S** or **Minikube** for a more lightweight local footprint.

---

**Author:** [Chris Ignat](https://github.com/chrisignat)  
**License:** [MIT](LICENSE)
