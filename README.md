# teracy-dev-v05-compat

The extension to use to help to port teracy-dev from v0.5's features to teracy-dev v0.6

So when this extension is used for teracy-dev v0.6, `teracy-dev` will have all the supported features
from v0.5


## How to use

Configure `workspace/teracy-dev-entry/config_default.yaml` with the following similar content:

```yaml
teracy-dev:
  extensions:
    - _id: "entry-0"
      path:
        extension: teracy-dev-v05-compat
      location:
        git: https://github.com/hoatle/teracy-dev-v05-compat.git
        branch: develop
      require_version: ">= 0.1.0-SNAPSHOT"
      enabled: true
```


## How to develop

Configure `workspace/teracy-dev-entry/config_override.yaml` with the follow similar content:


```yaml
teracy-dev:
  extensions:
    - _id: "entry-0"
      path:
        lookup: workspace # use workspace directory to lookup for this extension
      location:
        git: git@github.com:hoatle/teracy-dev-v05-compat.git # your forked repo
```

With this override configuration, you tells `teracy-dev` to use the `teracy-dev-v05-compat` extension
from the `workspace` directory
