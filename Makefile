PROTOTOOL = docker run --rm --user $$UID:$$UID -v `pwd`:/work uber/prototool:1.7.0 prototool

.PHONY: generate
generate:
	@$(PROTOTOOL) generate

.PHONY: ci
ci: lint compile

.PHONY: compile
compile:
	@$(PROTOTOOL) compile

.PHONY: lint
lint:
	@$(PROTOTOOL) lint

.PHONY: format
format:
	@$(PROTOTOOL) format -w

.PHONY: release-go
release-go: generate
	@./build/go/release.sh

.PHONY: clean
clean:
	@rm -rf .gen
	@rm -rf .build