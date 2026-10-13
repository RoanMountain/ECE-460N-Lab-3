#!/usr/bin/env bash
#
# Compiles lc3bsim3.c and runs every test in this folder.
#
#   tests/run_tests.sh               run all tests
#   tests/run_tests.sh 05_store      run only the named test(s)
#
# Each test NAME has:
#   NAME.asm / NAME.hex   the program (NAME.*.hex are loaded as extra files)
#   NAME.cmd              simulator commands fed to stdin
#   NAME.expect           lines that must appear in dumpsim, in this order
#                         (leading/trailing spaces ignored, '#' = comment)
# The dumpsim of each test is saved to tests/out/NAME.dumpsim.

ROOT=$(cd "$(dirname "$0")/.." && pwd)
TESTS="$ROOT/tests"
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT
SIM="$WORK/lc3bsim3"

gcc -std=c99 -Wall -o "$SIM" "$ROOT/lc3bsim3.c" || { echo "Build failed."; exit 1; }
mkdir -p "$TESTS/out"

names=("$@")
if [ ${#names[@]} -eq 0 ]; then
    for f in "$TESTS"/*.cmd; do names+=("$(basename "$f" .cmd)"); done
fi

pass=0
fail=0
for name in "${names[@]}"; do
    progs=("$TESTS/$name.hex")
    for extra in "$TESTS/$name".*.hex; do
        [ -e "$extra" ] && progs+=("$extra")
    done

    rm -f "$WORK/dumpsim"
    (cd "$WORK" && timeout 10 "$SIM" "$ROOT/ucode3" "${progs[@]}" \
        < "$TESTS/$name.cmd" > "$TESTS/out/$name.stdout" 2>&1)
    status=$?
    cp "$WORK/dumpsim" "$TESTS/out/$name.dumpsim" 2>/dev/null

    if [ $status -eq 124 ]; then
        echo "FAIL  $name  (timed out - did the program ever reach PC = 0?)"
        fail=$((fail + 1))
        continue
    fi
    if [ ! -f "$WORK/dumpsim" ]; then
        echo "FAIL  $name  (no dumpsim produced, see tests/out/$name.stdout)"
        fail=$((fail + 1))
        continue
    fi

    # Find the first expected line that does not appear (in order) in dumpsim.
    missing=$(awk '
        { sub(/^[ \t]+/, ""); sub(/[ \t\r]+$/, "") }
        NR == FNR { if ($0 != "" && $0 !~ /^#/) want[n++] = $0; next }
        i < n && $0 == want[i] { i++ }
        END { if (i < n) print want[i] }
    ' "$TESTS/$name.expect" "$WORK/dumpsim")

    if [ -z "$missing" ]; then
        echo "PASS  $name"
        pass=$((pass + 1))
    else
        echo "FAIL  $name"
        echo "      first expected line not found: \"$missing\""
        echo "      compare tests/$name.expect with tests/out/$name.dumpsim"
        fail=$((fail + 1))
    fi
done

echo
echo "$pass passed, $fail failed"
[ $fail -eq 0 ]
