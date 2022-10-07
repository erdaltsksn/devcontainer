.POSIX:

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# devcontainer_features_test Command
define devcontainer_features_test
	devcontainer features test . --features $(1) --base-image ubuntu:22.04
endef

.PHONY: test
test: ## Run all tests
	$(call devcontainer_features_test,\
		common-utils \
		go \
		hugo \
	)

.PHONY: test-common-utils
test-common-utils: ## Run the test for 'common-utils' feature
	$(call devcontainer_features_test,common-utils)

.PHONY: test-go
test-go: ## Run the test for 'go' feature
	$(call devcontainer_features_test,go)

.PHONY: test-hugo
test-hugo: ## Run the test for 'hugo' feature
	$(call devcontainer_features_test,hugo)
