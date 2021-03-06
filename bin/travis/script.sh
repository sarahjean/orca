#!/usr/bin/env bash

set -e

if [ -z "$1" ]; then
  echo "Missing required SUT argument, e.g.:"
  echo "$0 drupal/example"
  exit 127
fi

BIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"

function run {
  echo "> $@"
  eval "$@"
}

# Run integrated tests (in the presence of other Acquia product modules).
run ${BIN_DIR}/orca fixture:create -f --sut=$1
#run ${BIN_DIR}/orca tests:run

# Tear down the test fixture.
run ${BIN_DIR}/orca fixture:destroy -f

# Run isolated tests (in the absence of other Acquia product modules).
run ${BIN_DIR}/orca fixture:create --sut=$1 --sut-only
#run ${BIN_DIR}/orca tests:run
