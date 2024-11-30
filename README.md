# Javascript script flake
Just a collection of javascript scripts run via bun, in a nix flake so they can be invoked/installed conveniently.

> [!IMPORTANT]
> You must have either [Nix or NixOS](https://nixos.org/download/#download-nix) installed to run these commands.

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
# In your configuration.nix:
{
  environment.systemPackages = with pkgs; [
    inputs.jsscripts.packages.${pkgs.system}.script1
    inputs.jsscripts.packages.${pkgs.system}.script2
  ];
}
```
>[!IMPORTANT]
>You must also include the flake as an input in your flake.nix (or wherever you configure your flake inputs)
```
# In your flake.nix
{
  inputs = {
    jsscripts.url = "github:ilioscic/jsflake";
  };
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

