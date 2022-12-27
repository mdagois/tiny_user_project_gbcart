// Copyright 2022 Google LLC.
// SPDX-License-Identifier: Apache-2.0

pub fn user_module(io_in: u8) -> u8 {
  u8:0
}

#[test]
fn user_module_test() {
  let _= assert_eq(user_module(u8:0b0000_0000), u8:0);
  _
}