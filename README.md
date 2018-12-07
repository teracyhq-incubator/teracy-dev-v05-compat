# teracy-dev-v05-compat

The extension to use to help to port teracy-dev from v0.5's features to teracy-dev v0.6

So when this extension is used for teracy-dev v0.6, `teracy-dev` will have all the supported features
from v0.5


## Dependencies

This extension requires:

- teracy-dev:           >= 0.6.0-a5, < 0.7.0
- teracy-dev-core:      >= 0.4.0
- teracy-dev-essential: >= 0.2.0

See the `manifest.yaml` file for more information.


## How to use

Configure `workspace/teracy-dev-entry/config_default.yaml` with the following similar content:

- Use specific version:

```yaml
teracy-dev:
  extensions:
    - _id: "entry-v05-compat"
      path:
        extension: teracy-dev-v05-compat
      location:
        git:
          remote:
            origin: https://github.com/teracyhq-incubator/teracy-dev-v05-compat.git
          branch: v0.1.0
      require_version: ">= 0.1.0"
      enabled: true
```

- Use latest stable version (auto update):

```yaml
teracy-dev:
  extensions:
    - _id: "entry-v05-compat"
      path:
        extension: teracy-dev-v05-compat
      location:
        git:
          remote:
            origin: https://github.com/teracyhq-incubator/teracy-dev-v05-compat.git
          branch: master
      require_version: ">= 0.1.0"
      enabled: true
```

- Use latest develop version (auto update):

```yaml
teracy-dev:
  extensions:
    - _id: "entry-v05-compat"
      path:
        extension: teracy-dev-v05-compat
      location:
        git:
          remote:
            origin: https://github.com/teracyhq-incubator/teracy-dev-v05-compat.git
          branch: develop
      require_version: ">= 0.2.0-SNAPSHOT"
      enabled: true
```


See this example teracy-dev-entry setup: https://github.com/teracyhq-incubator/teracy-dev-entry-v05#how-to-use


## How to develop

You should configure the forked git repo into the `workspace` directory by adding the following
similar content into `workspace/teracy-dev-entry/config_override.yaml`:


```yaml
teracy-dev:
  extensions:
    - _id: "entry-v05-compat" # must match the _id configured from the config_default.yaml file
      path:
        lookup: workspace # use workspace directory to lookup for this extension
      location:
        git:
          remote:
            origin: git@github.com:hoatle/teracy-dev-v05-compat.git # your forked repo
            upstream: git@github.com:teracyhq-incubator/teracy-dev-v05-compat.git
          branch: develop
      require_version: ">= 0.2.0-SNAPSHOT"
```
