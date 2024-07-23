# Onur is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Onur is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Onur. If not, see <https://www.gnu.org/licenses/>.

# DEPENDENCIES: gawk, fzf, podman, java 17, Oracle GraalVM 22.0.2+9.1

.DEFAULT_GOAL := test

RUNNER ?= podman
NAME := onur-dart
VERSION := $(shell gawk '/version/ { print $$2 }' pubspec.yaml)
CONTAINER_IMAGE := registry.gitlab.com/${USER}/${NAME}:${VERSION}

.PHONY: commands
command:
	@${RUNNER} run --rm -it \
		--volume ${PWD}:/app:Z \
		--workdir /app \
		${CONTAINER_IMAGE} \
		bash -c 'dart $(shell cat container-commands | fzf)'

.PHONY: test
test:
	@${RUNNER} run --rm -it \
		--volume ${PWD}:/app:Z \
		--workdir /app \
		${CONTAINER_IMAGE} \
		bash -c 'dart test'

.PHONY: image.build
image.build:
	${RUNNER} build --file ./Containerfile \
		--tag ${CONTAINER_IMAGE} \
		--env ONUR_VERSION=${VERSION}

.PHONY: image.repl
image.repl:
	${RUNNER} run --rm -it \
		--volume ${PWD}:/app:Z \
		--workdir /app \
		${CONTAINER_IMAGE} bash

.PHONY: image.publish
image.publish:
	${RUNNER} push ${CONTAINER_IMAGE}

.PHONY: install
install:
	dart compile exe bin/onur.dart -o ${HOME}/.local/bin/onur

.PHONY: fmt
fmt:
	dart format ./lib ./bin

.PHONY: system
system:
	guix shell --pure --container
