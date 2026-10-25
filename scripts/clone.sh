#!/usr/bin/env bash
# Clone a repo from versions.env and check out its pinned SHA.
# Usage: clone.sh <PREFIX> <dir> [--recursive]
set -euo pipefail

cd "$(dirname "$0")/.."
set -a
# shellcheck disable=SC1091
source versions.env
set +a

prefix="$1"
dir="$2"
extra="${3:-}"

ref_var="${prefix}_REF"
branch_var="${prefix}_BRANCH"
sha="${!ref_var:-}"
branch="${!branch_var:-}"

if [[ -z "$sha" || -z "$branch" ]]; then
    echo "clone.sh: no entry for prefix '$prefix' in versions.env" >&2
    exit 1
fi

case "$prefix" in
    EDCB)        repo="tsukumijima/EDCB" ;;
    TVTEST)      repo="tsukumijima/TVTest" ;;
    PX4)         repo="tsukumijima/px4_drv" ;;
    LIBARIBB25)  repo="tsukumijima/libaribb25" ;;
    LUA)         repo="xtne6f/lua" ;;
    LUAZLIB)     repo="xtne6f/lua-zlib" ;;
    WRITEMULTI)  repo="tsukumijima/Write_Multi" ;;
    EMWUI)       repo="tsukumijima/EDCB_Material_WebUI" ;;
    PSISIARC)    repo="xtne6f/psisiarc" ;;
    PSISIMUX)    repo="xtne6f/psisimux" ;;
    TSMEMSEG)    repo="xtne6f/tsmemseg" ;;
    TSREADEX)    repo="xtne6f/tsreadex" ;;
    BONUDP)      repo="tsukumijima/BonDriver_UDP-TCP" ;;
    JKCNSL)      repo="xtne6f/jkcnsl" ;;
    TVCAS)       repo="tsukumijima/TvCas" ;;
    TVTVD)       repo="tsukumijima/TVTestVideoDecoder" ;;
    CASPROC)     repo="tsukumijima/CasProcessor" ;;
    NICOJK)      repo="xtne6f/NicoJK" ;;
    TVCAP)       repo="tsukumijima/TVCaptionMod2" ;;
    TVTWV2)      repo="tsukumijima/TVTDataBroadcastingWV2" ;;
    TVTPLAY)     repo="xtne6f/TvtPlay" ;;
    *) echo "clone.sh: unknown prefix '$prefix'" >&2; exit 1 ;;
esac

url="https://github.com/${repo}.git"
echo "clone.sh: ${repo} @ ${branch} -> ${sha:0:10} into ${dir} ${extra}"
git clone -b "$branch" $extra "$url" "$dir"
git -C "$dir" checkout --quiet "$sha"
