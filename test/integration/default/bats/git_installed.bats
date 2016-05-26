@test "gittt binary is found in PATH" {
  run which git
  [ "$status" -eq 0 ]
}
