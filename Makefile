numbas:
	docker build --tag=numbas .

stack:
	docker stack up --compose-file stack.yml numbas
