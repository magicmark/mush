THIS_MAKEFILE	:= $(lastword $(MAKEFILE_LIST))
ROOT			:= $(dir $(THIS_MAKEFILE))

deploy-%:
	@echo "Ensuring ECR registry exists for $(REPOSITORY)"
	"$(ROOT)/./check-ecr-repo.sh" "$(REPOSITORY)"
	@echo "Building and deploying version $*..."
	podman build --platform $(PLATFORM) -t $(ECR_REGISTRY)/$(REPOSITORY):$* .
	podman tag $(ECR_REGISTRY)/$(REPOSITORY):$* $(ECR_REGISTRY)/$(REPOSITORY):latest
	podman push $(ECR_REGISTRY)/$(REPOSITORY):$*
	podman push $(ECR_REGISTRY)/$(REPOSITORY):latest
	@echo "Successfully deployed version $* and latest to ECR"
	ssh $(HOST) "AWS_PROFILE=ecr docker pull $(ECR_REGISTRY)/$(REPOSITORY):latest"
	ssh $(HOST) "docker compose --project-directory /root/docker up -d --remove-orphans"
	@echo "Successfully deployed new version $* on host"
