# Run Without Installing

## Run script1
nix run github:yourusername/your-repo-name#script1

## Run script2
nix run github:yourusername/your-repo-name#script2

## Run using a specific commit
nix run github:yourusername/your-repo-name/commit-hash#script1

## Run using a tag
nix run github:yourusername/your-repo-name/v1.0.0#script1

# Installation

## Installation via configuration.nix (Standard)
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

## Installation via home-manager (Alternative)
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

# For Testing or Temporary Installation

## Install a single script
nix profile install github:ilioscio/jsflake#script1

## Or install both
nix profile install github:ilioscio/jsflake#script1 github:ilioscio/jsflake#script2

