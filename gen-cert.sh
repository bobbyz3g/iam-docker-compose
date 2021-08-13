#!/usr/bin/env bash
function cert::cd_dir() {
  cd "volumes/iam-config/cert" || exit
}

function cert::init() {
  cert::cd_dir
  echo "gen root pem"
  cfssl gencert -initca ca-csr.json | cfssljson -bare ca
}

function cert::gen() {
  cert::cd_dir
  local name=$1
  echo "gen ${name} pem"
  cfssl gencert -ca=ca.pem  -ca-key=ca-key.pem  -config=ca-config.json  -profile=iam "${name}-csr.json" | cfssljson -bare "${name}"
}

if [[ "$*" =~ cert:: ]];then
  eval $*
fi
