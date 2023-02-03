# AWS EC2 simple VM with Terraform and Packer

This is a proof of concept demonstrating the use of Terraform and Packer on AWS to create an EC2 instance using the latest Arch Linux AMI. The main way to interact with the project is through `make` commands, which include:

-   `img_gen`: Generates a new AMI using Packer.
-   `apply`: Applies Terraform without prompt and creates the EC2 instance.
-   `connect`: Connects to the EC2 instance using a custom script (`scripts/connect.sh`) and the output variables from Terraform.
-   `destroy`: Destroys the created EC2 instance.
-   `reload`: Does everything from scratch, including generating a new AMI, applying Terraform, and connecting to the EC2 instance.

## Recommended Order of Use

The recommended order to use the `make` commands is as follows:

1.  `img_gen`: This command generates a new AMI using Packer. This step is necessary before applying Terraform, as Terraform uses the AMI to create the EC2 instance.

2.  `apply`: This command applies the Terraform plan and creates the EC2 instance. The EC2 instance must be created before attempting to connect to it.

3.  `connect`: This command connects to the EC2 instance using the custom script (`./scripts/connect.sh`) and the output variables from Terraform. This step can only be performed after the EC2 instance has been created by applying Terraform.

4.  `destroy`: This command destroys the EC2 instance. This step can only be performed after the EC2 instance has been created by applying Terraform.


It is important to note that using the `make` commands without `reload` will not start the infrastructure from scratch. To start fresh, the `reload` command must be used, which includes `img_gen`, `apply`, and `connect`.

## Prerequisites

Before using this project, make sure you have the following installed on your local machine:

-   [Terraform](https://www.terraform.io/downloads.html)
-   [Packer](https://packer.io/downloads)
-   [AWS CLI](https://aws.amazon.com/cli/)
-   An AWS account

## Usage

1.  Clone this repository to your local machine.
`$ git clone https://github.com/YOUR-REPO`

2.  Run the following command to set up your AWS CLI credentials:
`$ aws configure`

3.  Run the desired `make` command to interact with the project.
$ make img_gen
$ make apply
$ make connect
$ make destroy
$ make reload

## Conclusion

This proof of concept demonstrates the use of Terraform and Packer on AWS to create an EC2 instance using the latest Arch Linux AMI. The project uses `make` commands to simplify interaction with the infrastructure, and provides a recommended order for the commands to ensure a seamless experience.
