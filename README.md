# mush

## Your local makefile

Include this in your makefile:

```mf
ECR_REGISTRY = ""  # e.g. 123456789.dkr.ecr.us-east-1.amazonaws.com
REPOSITORY   = ""  # e.g. library/ubuntu
PLATFORM     = ""  # e.g. linux/amd64
HOST         = ""  # e.g. root@1.2.3.4

include ~/apps/mush/mush.mk
```

...then run `$ make deploy-<version>`

## docker credentials

set up an IAM user with the following permissions:

<details>
```json
{
}
```
</details>

### using profiles (reccomended)

Add an `ecr` user to both local laptop and remote docker host:

**`~/.aws/credentials`**
```ini
[ecr]
aws_access_key_id = ...
aws_secret_access_key = ...
```

**`~/.aws/config`**
```ini
[profile ecr]
region = us-east-2
```

### manually logging in

You can run something this command to authenticate against ECR:

```
$ AWS_ACCESS_KEY_ID="..." AWS_SECRET_ACCESS_KEY="..." aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 123456789.dkr.ecr.us-east-2.amazonaws.com
```

(s/docker/podman/ if needed)
