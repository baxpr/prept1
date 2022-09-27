#!/usr/bin/env bash

flirt \
    -usesqform \
    -ref INPUTS/mprage1 \
    -in INPUTS/mprage2 \
    -out OUTPUTS/rmprage2

flirt \
    -usesqform \
    -ref INPUTS/mprage1 \
    -in INPUTS/mprage3 \
    -out OUTPUTS/rmprage3

fslmaths INPUTS/mprage1 -add OUTPUTS/rmprage2 -add OUTPUTS/rmprage3 -div 3 OUTPUTS/mrmprage