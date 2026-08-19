# cloche-xe tests

Smoke test only — cloche-xe isn't part of the pro-workstation vs cloche-standard parity gap
analysis (see workspace-root `CLAUDE.md`), so this is intentionally lighter than those two suites.

Uses the shared harness — see [cloche-utils/testing/README.md](../../cloche-utils/testing/README.md)
for `test-lib.sh` details, local/CI usage, and the `CLOCHE_UTILS_DIR` env var.

Run: `./tests/run.sh [image-tag] [recipe-file]` (`BUILD_METHOD=bluebuild`).

cloche-xe ships multiple recipe variants (xe + Steam Deck `deck*.yml`, per `CLAUDE.md`), so the
recipe file is a second positional arg rather than hardcoded — run once per variant:

```sh
./tests/run.sh cloche-xe-test ./recipes/deck.yml
```

## Checks

- Recipe builds successfully.
- Built image reports the expected base image (`ghcr.io/cloche-project/cloche` per `CLAUDE.md`'s repo table).

## ⚠️ Unverified — confirm before trusting in CI

Not confirmed against this repo's actual `recipes/` tree (no shell/search tooling was available
when this suite was written):

- Default `RECIPE` in `run.sh` — placeholder is `./recipes/cloche-xe.yml`; confirm the real
  filename(s), including the `deck*.yml` variants.
- The base-image detection check (`os-release` / `rpm-ostree status` grep) — confirm it actually
  matches how this image reports its base, and whether Deck variants report differently.
