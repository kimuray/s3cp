#!/bin/bash

aws s3 cp ./texts s3://text-delivery/texts --recursive
