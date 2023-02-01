#!/bin/bash

cd qir-runner
cargo run ../qir/input.ll
cargo run ../qir/output.ll
