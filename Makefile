NAME=test
all: ctreate-docker-network create-resolver-dir add-test-resolver configure-test-resolver

# Use this command to add another resolver
# `make add-resolver NAME=testdomain`
add-resolver: add-test-resolver configure-test-resolver

remove-resolver:
	@echo "Removing /etc/resolver/${NAME}."
	sudo rm /etc/resolver/${NAME}


# Skip if network has already been created
create-docker-network:
	@echo "Creating Docker Network Dash"
	@docker network create dash

# Create resolver dir
create-resolver-dir:
	@echo "Step 5.1 - Create a resolver directory in /etc."
	@mkdir -p /etc/resolver

# Create resolver for test domain file
add-test-resolver:
	@echo "Step 5.2 - Add a file named test in that directory with your text editor"
	@sudo touch /etc/resolver/${NAME}
	
# configure resolver test domain 
configure-test-resolver:
	@echo "Step 5.3 - add nameserver 127.0.0.1. to /etc/resolver/${NAME}."
	@sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/${NAME}';
