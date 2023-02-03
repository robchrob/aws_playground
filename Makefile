.PHONY: apply

default: reload

img_gen:
	packer build ./packer/arch-latest.pkr.hcl

apply:
	terraform plan
	terraform apply -auto-approve

connect:
	./scripts/connect.sh

destroy:
	terraform destroy -auto-approve

reload: img_gen apply connect
