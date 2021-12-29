#!/usr/bin/env bash

{
echo block pre sleep
ls -li $0
sleep 5
echo block post sleep copied.
ls -li $0
exit
}