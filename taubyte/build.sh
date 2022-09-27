#!/bin/bash

yarn global add @vue/cli
yarn install
yarn audit fix
yarn build && mv dist/* /out