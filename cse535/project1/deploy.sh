#!/bin/bash
cargo build --release
ssh root@198.58.119.218 rm /bin/project1
scp ./target/release/project1 root@198.58.119.218:/bin/project1
ssh root@198.58.119.218 systemctl restart project1
