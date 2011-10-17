#! /bin/bash

git log --pretty=format:'%h by %an (%ar): %s'  --since='2 weeks ago'
