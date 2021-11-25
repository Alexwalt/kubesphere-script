#!/bin/bash

. ./common.sh

docker_start() {
    if command_exists systemctl; then
      log_command systemctl start docker && systemctl enable docker
    fi
}

docker_rm()
{
  log_command "docker rm -f $1"
  log_command "docker rmi $2"
  docker_logout
}

docker_login()
{
  if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PWD" ]; then
    DOCKER_USER=$(echo -n "${DOCKER_USER}"|base64 -d)
    DOCKER_PWD=$(echo -n "$DOCKER_PWD" | base64 -d)
    if bash -c "echo '$DOCKER_PWD' | docker login --username $DOCKER_USER --password-stdin $DOCKER_WAREHOUSE"; then
        log_info "docker登录成功"
    elif bash -c "docker login --username $DOCKER_USER --password '$DOCKER_PWD' $DOCKER_WAREHOUSE"; then
      log_info "docker登录成功"
    else
      log_error "docker登录失败"
      exit 1
    fi
  fi
}

docker_logout()
{
  if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PWD" ]; then
      docker logout "$DOCKER_WAREHOUSE"
  fi
}