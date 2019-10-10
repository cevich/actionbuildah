
ARTIFACTS_DIRPATH ?= $(if $(INPUT_ARTIFACTS_DIRPATH),$(INPUT_ARTIFACTS_DIRPATH),$(CURDIR))

.PHONY: all
all:
	@echo "This makefile is intended for testing this Github Action, use by other contexts may not do what you expect."

$(ARTIFACTS_DIRPATH):
	mkdir -vp "$@"

.PHONY: set_artifact
set_artifact: $(ARTIFACTS_DIRPATH)
	@echo "Writing $(ARTIFACTS_DIRPATH)/artifact"
	@echo "::set-env name=testing::passed" > $(ARTIFACTS_DIRPATH)/artifact

.PHONY: get_artifact
get_artifact: $(ARTIFACTS_DIRPATH)/artifact
	@cat $<

.PHONY: versions
versions:
	skopeo --version
	buildah --version
	podman --version
