# VPC Module

This module creates the following:
* A VPC with the Provided CIDR with Hostname and DNS Support Enabled
* An Internet Gateway in the VPC
* Public Subnets and Private Subnets with the provided CIDRs
* A Nat Gateway in the 1st Public Subnet
* A Route Table for Route to Internet Gateway with association to Public Subnets
* A Route Table for Route to Nat Gateway with association to Private Subnets

**Inputs Required:**

Input Name | Sample Value | Description |
--- | --- | --- |
vpc_cidr_block | "10.0.0.0/16" | VPC CIDR |
env | "dev" | Environment Prefix for Resources |
azs | ["us-west-2a", "us-west-2b"] | Availability Zones |
private_subnets | ["10.0.0.0/19", "10.0.32.0/19"] | Private Subnet CIDR Ranges |
public_subnets | ["10.0.64.0/19", "10.0.96.0/19"] | Public Subnet CIDR Ranges |


**Outputs:**
Output | Sample Value | Description |
--- | --- | --- |
vpc_id | "vpc-0cbcf9dc884a5d2cb" | VPC ID |
private_subnet_ids | [ "subnet-08adb5ca4fb972fea", "subnet-035c913f068824be1"] | Private Subnet IDs |
public_subnet_ids | [ "subnet-0bf221338db395a57", "subnet-0e08ef7bc327618aa"] | Public Subnet IDs |