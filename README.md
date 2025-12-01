# mush

## Your local makefile

Include this in your makefile:

```mk
ECR_REGISTRY = ""  # e.g. 123456789.dkr.ecr.us-east-1.amazonaws.com
REPOSITORY   = ""  # e.g. library/ubuntu
PLATFORM     = ""  # e.g. linux/amd64
HOST         = ""  # e.g. root@1.2.3.4

include ~/apps/mush/mush.mk
```

...then run `$ make deploy-<version>`
