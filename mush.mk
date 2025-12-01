deploy-%:
	@echo "Building and deploying version $*..."
	podman build --platform $(PLATFORM) -t $(ECR_REGISTRY)/$(IMAGE_NAME):$* .
	podman tag $(ECR_REGISTRY)/$(IMAGE_NAME):$* $(ECR_REGISTRY)/$(IMAGE_NAME):latest
	podman push $(ECR_REGISTRY)/$(IMAGE_NAME):$*
	podman push $(ECR_REGISTRY)/$(IMAGE_NAME):latest
	@echo "Successfully deployed version $* and latest to ECR"
	ssh $(HOST) "AWS_PROFILE=ecr docker pull $(ECR_REGISTRY)/$(IMAGE_NAME):latest"
	ssh $(HOST) "docker compose --project-directory /root/docker up -d --remove-orphans"
	@echo "Successfully deployed new version $* on host"
