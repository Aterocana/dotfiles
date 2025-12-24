---
name: Generate Tests
interaction: inline
description: Generate unit tests
opts:
  alias: tests
  auto_submit: true
  modes:
    - v
  placement: new
  stop_context_insertion: true
---

## system

Generate comprehensive unit tests for the provided code.

## user

The code to generate tests for is #{buffer}
