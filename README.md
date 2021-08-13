# iam-docker-compose

docker compose for [iam](https://github.com/marmotedu/iam)

## Quick start

### Prepare databases

1. Create docker network for iam services

```shell
$ docker network create iam
```

2. Start databases

```shell
$ docker-compose -f database.docker-compose.yaml up -d
```

3. Config MariaDB

```shell
$ export IAM_ROOT=<path-to-iam-project>
$ docker cp ${IAM_ROOT}/configs/iam.sql mysql.iam:/tmp/
$ docker exec -it mysql.iam mysql -uroot -p1qaz2ws
MariaDB [(none)]> source /tmp/iam.sql
MariaDB [(none)]> exit
```

4. Config Mongo

```shell
$ docker exec -it mongo.iam mongo -uroot -p1qaz2ws
> use iam_analytics
> db.createUser({user:"iam", pwd:"1qaz2ws",roles:["dbOwner"]})
> db.auth("iam", "1qaz2ws")
> exit
```

### Start services

1. Build image

```shell
$ cd ${IAM_ROOT}
$ git checkout 210a49c
$ make image
$ cd -
$ docker-compose up -d
```

2. Generate cert files

```shell
$ ./gen-cert cert::init
$ ./gen-cert cert::gen iam-apiserver
$ ./gen-cert cert::gen iam-authz-server
$ ./gen-cert cert::gen admin
```

3. Start services

```shell
$ docker-compose up -d
```
