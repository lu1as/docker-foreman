#!/bin/bash


cfssl gencert -initca ssl/ca.json | cfssljson -bare ssl/ca -
cfssl gencert -ca=ssl/ca.pem -ca-key=ssl/ca-key.pem  -profile=server ssl/server.json | cfssljson -bare ssl/server
