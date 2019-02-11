export ROOT_DIR=$(CURDIR)
export DOCKER_REPO=nickvanw

MODULES=$(dir $(wildcard */Makefile))

.PHONY: clean
clean: ## Call the 'clean' target on all sub-modules
	$(foreach mod,$(MODULES),($(MAKE) -C $(mod) $@) || exit $$?;)

.PHONY: build
build: ## Call the 'build' target on all sub-modules
	$(foreach mod,$(MODULES),($(MAKE) -C $(mod) $@) || exit $$?;)

.PHONY: test
test: ## Call the 'test' target on all sub-modules
	$(foreach mod,$(MODULES),($(MAKE) -C $(mod) $@) || exit $$?;)

.PHONY: publish
publish: ## Call the 'publish' target on all sub-modules
	$(foreach mod,$(MODULES),($(MAKE) -C $(mod) $@) || exit $$?;)

.PHONY: dev-all
dev-all: lint build test

include make/help.mk
