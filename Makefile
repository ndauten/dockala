.PHONY: clean-docker-logs

# Path to the script
DOCKER_CLEAN_SCRIPT := scripts/docker_log_cleanup.sh

# Default target
all:
	@echo "Use 'make clean-docker-logs' to truncate all Docker container logs"

# Run the log cleanup script
clean-docker-logs:
	@echo "Running Docker log cleanup..."
	@chmod +x $(DOCKER_CLEAN_SCRIPT)
	@sudo $(DOCKER_CLEAN_SCRIPT)

