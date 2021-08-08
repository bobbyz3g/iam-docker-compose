#!/usr/bin/env bash
cd "volumes/iam-config/cert" || exit

echo "gen root pem"
cfssl gencert -initca ca-csr.json | cfssljson -bare ca

echo "gen api server pem"
cfssl gencert -ca=ca.pem  -ca-key=ca-key.pem  -config=ca-config.json  -profile=iam iam-apiserver-csr.json | cfssljson -bare iam-apiserver

echo "gen api server pem"
cfssl gencert -ca=ca.pem  -ca-key=ca-key.pem  -config=ca-config.json  -profile=iam iam-authz-server-csr.json | cfssljson -bare iam-authz-server
