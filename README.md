# Javascript script flake
Just a collection of javascript scripts run via bun, in a nix flake so they can be invoked/installed conveniently.

## Run Without Installing

### Run script1
```
nix run github:ilioscio/jsflake#script1
```

### Run script2
```
nix run github:ilioscio/jsflake#script2
```

### Run using a specific commit
```
nix run github:ilioscio/jsflake/commit-hash#script1
```

### Run using a tag
```
nix run github:ilioscio/jsflake/v1.0.0#script1
```

## Installation

### Installation via configuration.nix (Standard)
```
{
  inputs.jsscripts.url = "github:ilioscio/jsflake";
  
  # In your configuration:
  environment.systemPackages = with pkgs; [
    jsscripts.script1
    jsscripts.script2
  ];
}
```

### Installation via home-manager (Alternative)
```
{
  inputs.jsscripts.url = "github:ilioscio/jsflake";
  
  # In your home.nix:
  home.packages = with pkgs; [
    jsscripts.script1
    jsscripts.script2
  ];
}
```

## For Testing or Temporary Installation

### Install a single script
```
nix profile install github:ilioscio/jsflake#script1
```

### Or install both
```
nix profile install github:ilioscio/jsflake#script1 github:ilioscio/jsflake#script2
```

