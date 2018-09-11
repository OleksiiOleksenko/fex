#!/usr/bin/env bash

if [ ! -d /data/ ]; then
    mkdir /data/
fi

function download_and_link {
    local name=$1
    local url=$2
    local path=$3

    cd /data/

    if [ -d "${name}" ]; then
        rm -rf ${name}
    fi

    wget -nc ${url}
    tar xf ${name}.tar.*
    ln -s /data/${name} ${path}

    cd -

}

function clone_github_and_link {
    local name=$1
    local url=$2
    local path=$3
    local version=$4
    local applypatch=$5

    cd /data/

    if [ -d "${name}" ]; then
        rm -rf ${name}
    fi

    git clone ${url} ${name}
    pushd ${name}
    if [ !  -z ${version} ]; then
        git checkout tags/${version}
    fi
    if [ !  -z ${applypatch} ]; then
        git apply ${applypatch}
    fi
    popd

    ln -s /data/${name} ${path}

    cd -

}

function download_github_and_link {
    local name=$1
    local url=$2
    local path=$3
    local branch=$4

    cd /data/

    if [ -d "${name}" ]; then
        rm -rf ${name}-${branch}
    fi

    set +e
    wget -O ${name}.zip -nc ${url}
    set -e

    unzip ${name}.zip
    ln -s /data/${name}-${branch} ${path}

    cd -
}

function install_dependency {
    local name=$1
    local path=$2

    while true; do
        read -p "Do you wish to install $1 [Yn]?" yn
        case $yn in
            [Yy]* ) eval "$2"; break;;
            [Nn]* ) echo "Skip"; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
