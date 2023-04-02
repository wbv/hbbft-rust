#!/bin/bash

export RUST_LOG=hbbft=warn,consensus_node=warn
export RUST_BACKTRACE=1

DELAY_SEC=0

cargo build --release --example consensus-node

cargo run --release --example consensus-node -- --bind-address=127.0.0.1:5000 --remote-address=127.0.0.1:5001 --remote-address=127.0.0.1:5002 --remote-address=127.0.0.1:5003 --remote-address=127.0.0.1:5004 --value=SomeNewMessageHereEh &
sleep ${DELAY_SEC}
cargo run --release --example consensus-node -- --bind-address=127.0.0.1:5001 --remote-address=127.0.0.1:5000 --remote-address=127.0.0.1:5002 --remote-address=127.0.0.1:5003 --remote-address=127.0.0.1:5004 &
sleep ${DELAY_SEC}
cargo run --release --example consensus-node -- --bind-address=127.0.0.1:5002 --remote-address=127.0.0.1:5000 --remote-address=127.0.0.1:5001 --remote-address=127.0.0.1:5003 --remote-address=127.0.0.1:5004 &
sleep ${DELAY_SEC}
cargo run --release --example consensus-node -- --bind-address=127.0.0.1:5003 --remote-address=127.0.0.1:5000 --remote-address=127.0.0.1:5001 --remote-address=127.0.0.1:5002 --remote-address=127.0.0.1:5004 &
sleep ${DELAY_SEC}
cargo run --release --example consensus-node -- --bind-address=127.0.0.1:5004 --remote-address=127.0.0.1:5000 --remote-address=127.0.0.1:5001 --remote-address=127.0.0.1:5002 --remote-address=127.0.0.1:5003 &
wait
