#!/usr/bin/env bash
# Fails if app code uses physical left/right layout APIs instead of the
# directional ones (docs/01-architecture.md §10.3). Phone/code fields that are
# deliberately LTR use TextDirection.ltr + TextAlign.left and are allowed.
set -euo pipefail
cd "$(dirname "$0")/.."

pattern='EdgeInsets\.(only|fromLTRB)\(|Alignment\.(centerLeft|centerRight|topLeft|topRight|bottomLeft|bottomRight)|Positioned\((left|right):|BorderRadius\.only\((topLeft|topRight|bottomLeft|bottomRight)'
if matches=$(grep -rnE "$pattern" lib --include='*.dart' --exclude-dir=gen | grep -v 'rtl-ok'); then
  echo "Use directional APIs (EdgeInsetsDirectional, AlignmentDirectional, PositionedDirectional, BorderRadiusDirectional):"
  echo "$matches"
  echo "(Append '// rtl-ok: <reason>' to a line if a physical side is truly intended.)"
  exit 1
fi
echo "RTL check passed."
