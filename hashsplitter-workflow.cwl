#!/usr/bin/env cwlrunner

class: Workflow

cwlVersion: v1.0

inputs:
  - id: input
    type: File
    doc: "to be hashed all the ways"

outputs:
  - id: output
    type: File
    outputSource: unify-once-again/output

steps:
  - id: md5
    run: hashsplitter-md5.cwl.yml
    in:
      - { id: input, source: input }
    out:
      - { id: output }

  - id: sha
    run: hashsplitter-sha.cwl.yml
    in:
      - { id: input, source: input }
    out:
      - { id: output }

  - id: whirlpool-testhyphen
    run: hashsplitter-whirlpool.cwl.yml
    in:
      - { id: input, source: input }
    out:
      - { id: output }

  - id: unify-once-again
    run: hashsplitter-unify.cwl.yml
    in:
      - { id: md5, source: md5/output }
      - { id: sha, source: sha/output }
      - { id: whirlpool-testhyphen, source: whirlpool-testhyphen/output }
    out:
      - { id: output }
