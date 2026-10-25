# dtv-stack

Personal build recipes for the Japanese DTV (TS-capture) stack, producing x64-only Windows
binaries via GitHub Actions:

- **EDCB** (tkntrec lineage via tsukumijima's fork) + libaribb25, Material WebUI, tools
- **TVTest** (DBCTRADO develop via tsukumijima's fork) + bundled plugins
- **px4_drv for WinUSB** (tsukumijima's fork) + per-device BonDrivers

Derived from [tsukumijima/DTV-Builds](https://github.com/tsukumijima/DTV-Builds), with the
following changes:

- 64-bit builds only (halves build time and artifact size)
- Artifacts are published to GitHub Releases instead of committed to the repo
- Source repos are pinned by commit SHA in `versions.env`, kept fresh by Renovate
- Customizations are maintained as `patches/*.patch` (applied with `git apply`) instead of
  maintaining source forks

## Layout

```
.github/workflows/   build_edcb.yml / build_tvtest.yml / build_px4_drv.yml
assets/              settings overlay copied onto package output (generic defaults)
patches/             git-apply patches for compiled-in tweaks (fonts, colors)
versions.env         pinned commit SHAs of every cloned repo (Renovate-managed)
```

## Security model

This repo contains **no secrets and no personal values**. See `.gitignore` for the
deny-list (`glpasswd`, `ssl_cert.pem`, `jkcnsl.json`, …) — those files are generated at
runtime on the machine where the apps are deployed and are never committed here.
Personalized settings (postal code, tuner IPs, DDNS names) belong in a separate private
repository.

## Status

Workflows are complete and production-validated (all three built green
with Releases published).
