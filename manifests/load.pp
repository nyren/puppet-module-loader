define loader::load(
  $cls = $title,
  $classes = {},
) {
  $enable = $classes[$cls]

  # Hash key must be a boolean
  if has_key($classes, $cls) {
    validate_bool($enable)
  }

  if $enable == true {
    include $cls
  }
}
