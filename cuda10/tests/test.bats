source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(cuda10 -V | head -1 | awk '{print $4}')"
  [ "$result" = "${pkg_version}" ]
}
