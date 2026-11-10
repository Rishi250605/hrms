#!/usr/bin/env bash
# Regenerates the Dart API client (packages/hrms_api) from ../api/openapi/openapi.yaml.
# Requires: Node (npx) and Java 11+ (JAVA_HOME or java on PATH). Do not hand-edit packages/hrms_api.
set -euo pipefail
cd "$(dirname "$0")/.."

SPEC=../api/openapi/openapi.yaml
OUT=packages/hrms_api

rm -rf "$OUT/lib" "$OUT/doc"
npx --yes @openapitools/openapi-generator-cli@2.42.0 generate \
  -i "$SPEC" \
  -g dart-dio \
  -o "$OUT" \
  -c tool/openapi-generator-config.yaml

# Post-process the generated pubspec: current json_serializable emits Dart >= 3.8 syntax
# (null-aware elements) and the generator writes a placeholder homepage.
sed -i.bak -E "s/sdk: '>=[0-9.]+ <4.0.0'/sdk: '>=3.8.0 <4.0.0'/; /^homepage: homepage$/d" "$OUT/pubspec.yaml" && rm "$OUT/pubspec.yaml.bak"

(cd "$OUT" && dart pub get && dart run build_runner build && dart format lib > /dev/null)
flutter pub get
echo "API client regenerated in $OUT"
