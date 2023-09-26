default: init


tools:
	@echo "==> installing required tooling..."
	go install github.com/terraform-docs/terraform-docs@v0.16.0

documentation:
	terraform-docs markdown "$(CURDIR)" --output-file README.md

graph:
	@sh -c "'$(CURDIR)/scripts/terraform-graph.sh'"

clean:
	rm --force --recursive --verbose .terraform

init-upgrade:
	terraform init \
		-input=false \
		-lock-timeout=0s \
		-lock=true \
		-no-color \
		-upgrade \
	&& terraform providers lock \
		-platform=windows_amd64 \
		-platform=darwin_amd64 \
		-platform=linux_amd64

init:
	terraform init \
		-input=false \
		-lock-timeout=0s \
		-lock=true \
		-lockfile=readonly \
		-no-color \
	&& terraform providers lock \
		-platform=windows_amd64 \
		-platform=darwin_amd64 \
		-platform=linux_amd64

fmt: init
	terraform fmt \
		-recursive . \
	&& terraform fmt \
		-check \
		-diff \
		-list=true \
		-recursive \
		-write=false

fmt-only:
	terraform fmt \
		-recursive . \
	&& terraform fmt \
		-check \
		-diff \
		-list=true \
		-recursive \
		-write=false

validate: fmt
	terraform validate \
		-no-color

validate-only:
	terraform validate \
		-no-color


.PHONY: \
	build \
	documentation \
	fmt \
	fmt-only \
	graph \
	init \
	init-upgrade \
	tools \
	validate \
	validate-only
