#!/bin/bash

cd qir-runner
cargo run -- --file ../qir/input.ll
cargo run -- --file ../qir/output.ll
