# cluster-mongo

![CircleCI](https://circleci.com/gh/wiltonfelix/cluster-mongodb.svg?style=shield&circle-token=6ca800e5db27e2ba0a7c361a562c3b1a4900edf9)


## Objetivo

Criar um cluster de Mongodb na **AWS** usando as ferramentas Terraform e Ansible.

## Requisitos
As seguintes ferramentas instaladas:
* [Terraform](https://www.terraform.io/downloads.html)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [Credencias AWS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create.html)



## Como usar
```
git clone https://github.com/wiltonfelix/cluster-mongodb.git

cd cluster-mongodb
```
### Edite as variáveis nos seguintes locais

#### mongodb/vars.tf

* `protocol`: Protocolo que vai ser usado para o security group (*default*:*tcp*)
* `from_port`: Porta que fica liberada para acesso (*default*:*0*)
* `to_port`: Porta que fica liberada para acesso das intancias (*default*:*65535*)
* `range`: Range de ips que vão ter acesso as instancias, libere apenas para o range da sua vpc (*default*:*0.0.0.0/0*)
* `vpc_id`: Id da vpc (*vpc_id*:*vpc-a7aaa3de*)
* `public_ip`: Deixe o valor default caso queria que a instancia tenha ip publico associado a ela (*default*:*true*)
* `app_name`: Tag com nome da aplicação, é necessario informa um valor (*default*:*uso no CircleCI*)
* `subnet_ids`: Lista de ids de subnets, sendo necessarias pelo menos três, caso não tenha repita o valor (*default*:*subnet-3a14fb71,subnet-60be6504,subnet-3a14fb71*)
* `key_pair`: Nome da key pair que vai ser associada as instancias (*default*:*wilton*)
* `instance_type`: Tipo das instancias (*default*:*t2.small*)
* `environment`: Tag com o nome do ambiente, é necessario informa o valor (*default*:*uso no CircleCI*)
* `number_of_instances`: Número de instancias que o terraform vai criar, não mudar o valor (*default*:*3*)
* `volume_size_root`: Tamanho do disco root da instancia em GB (*volume_size_root*:*8*)
* `volume_size_mongodb`: Tamanho do disco que vai ser usado pelo Mongodb em GB (*volume_size_mongodb*:*30*)
* `local_key`: Local onde a key pair para ssh está, nesserio ser a mesma que a **key_pair** (*default*:*uso no CircleCI*)
* `domain`: Dominio onde vai ser criar as entradas de DNS para o cluster de Mongodb (*default*:*uso no CircleCI*)
