# Cluster-mongoDB

![CircleCI](https://circleci.com/gh/wiltonfelix/cluster-mongodb.svg?style=shield&circle-token=6ca800e5db27e2ba0a7c361a562c3b1a4900edf9)


## Objetivo

Criar um cluster de Mongodb na **AWS** usando as ferramentas Terraform e Ansible.


## Requisitos
As seguintes ferramentas instaladas:
* [Terraform](https://www.terraform.io/downloads.html)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [Credencias AWS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create.html)
* [AWS cli](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/installing.html)



## Como usar
```
git clone https://github.com/wiltonfelix/cluster-mongodb.git

cd cluster-mongodb
```

### Edite as variáveis nos seguintes arquivos


#### mongodb/vars.tf

* `protocol`: Protocolo que vai ser usado para o security group (*default*:*tcp*)
* `from_port`: Porta que fica liberada para acesso (*default*:*0*)
* `to_port`: Porta que fica liberada para acesso das intancias (*default*:*65535*)
* `range`: Range de ips que vão ter acesso as instancias, libere apenas para o range da sua vpc (*default*:*0.0.0.0/0*)
* `vpc_id`: Id da vpc (*vpc_id*:*vpc-a7aaa3de*)
* `public_ip`: Deixe o valor default caso queria que a instancia tenha ip publico associado a ela (*default*:*true*)
* `app_name`: Tag com nome da aplicação, é necessario informa um valor (*default*:*uso no CircleCI*)
* `subnet_ids_aws`: Lista de ids de subnets, sendo necessarias pelo menos três, caso não tenha repita o valor (*default*:*subnet-3a14fb71*,*subnet-60be6504*,*subnet-3a14fb71*)
* `key_pair`: Nome da key pair que vai ser associada as instancias (*default*:*wilton*)
* `instance_type`: Tipo das instancias (*default*:*t2.small*)
* `environment`: Tag com o nome do ambiente, é necessario informa o valor (*default*:*uso no CircleCI*)
* `number_of_instances`: Número de instancias que o terraform vai criar, não mudar o valor (*default*:*3*)
* `volume_size_root`: Tamanho do disco root da instancia em GB (*volume_size_root*:*8*)
* `volume_size_mongodb`: Tamanho do disco que vai ser usado pelo Mongodb em GB (*volume_size_mongodb*:*30*)
* `local_key`: Local onde a key pair para ssh está, nesserio ser a mesma que a **key_pair** (*default*:*uso no CircleCI*)
* `domain`: Dominio onde vai ser criar as entradas de DNS para o cluster de Mongodb (*default*:*uso no CircleCI*)


#### ansible/roles/mongod/defaults/main.tf

* `mongodb_version`: Versão do Mongodb que vai ser instalada (*default*:*3.4*)
* `mongodb_dbpath`: Caminho onde vai ser montado o disco para ser usado pelo Mongodb (*default*:*/data/mongodb*)
* `mongodb_systemlog_path`: Caminho onde vão ser gerado os logs do Mongodb (*default*:*/var/log/mongodb/mongod.log*)
* `mongodb_port`: Porta que o Mongodb usa para se comunicar (*default*:*27017*)
* `mongodb_replication_set_name`: Nome da Replica Set do Mongodb (*default*:*wilton-git*)
* `user_name`: Usuário administrador do Mongodb (*default*:*admin*)
* `user_password`: Senha do usuário administrador do Mongodb (*default*:*admin*)


#### ansible/inventory/ec2.ini

* `vpc_destination_variable`: necessário alterar para o valor correto, caso o valor definido na variável do terraform **public_ip** seja **true** defina como **ip_address**, em caso de **false** defina como **private_ip_address**


## Executando
```
terraform init

terraform apply

```
