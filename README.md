The following fails:
```
nix develop
```

The following passes:

```
nix develop --override-input haskell-flake github:srid/haskell-flake/c301f31092a74a6acde9d98d6431ea0a9952ca0f
```
