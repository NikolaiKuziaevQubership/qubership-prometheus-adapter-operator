VERSION ?= 0.0.1

# Get the currently used golang install path (in GOPATH/bin, unless GOBIN is set)
ifeq (,$(shell go env GOBIN))
GOBIN=$(shell go env GOPATH)/bin
else
GOBIN=$(shell go env GOBIN)
endif

all: manager

# Run tests
test: generate fmt vet
	ginkgo ./... -coverprofile cover.out

# Build manager binary
manager: generate fmt vet
	go build -o bin/manager main.go

# Run against the configured Kubernetes cluster in ~/.kube/config
run: generate fmt vet
	go run ./main.go

# Run go fmt against code
fmt:
	go fmt ./...

# Run go vet against code
vet:
	go vet ./...

# Generate code:
#   - DeepCopy, DeepCopyInto, and DeepCopyObject method implementations to zz_generated.deepcopy.go files
#   - CRD-s files to /charts/qubership-prometheus-adapter-operator/crds.
#     Note: produces CRDs that work back to Kubernetes 1.11 (no version conversion)
generate: controller-gen
	$(CONTROLLER_GEN) crd:crdVersions={v1} \
					  object:headerFile="hack/boilerplate.go.txt" \
					  paths="./..." \
					  output:crd:artifacts:config=charts/qubership-prometheus-adapter-operator/crds/ \

# Find or download controller-gen
# download controller-gen if necessary
controller-gen:
ifeq (, $(shell which controller-gen))
	@{ \
	set -e ;\
	CONTROLLER_GEN_TMP_DIR=$$(mktemp -d) ;\
	cd $$CONTROLLER_GEN_TMP_DIR ;\
	go mod init tmp ;\
	go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.16.5 ;\
	rm -rf $$CONTROLLER_GEN_TMP_DIR ;\
	}
CONTROLLER_GEN=$(GOBIN)/controller-gen
else
CONTROLLER_GEN=$(shell which controller-gen)
endif
