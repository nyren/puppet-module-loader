#
# ## Class: loader ##
#
# Load other Puppet modules
#
class loader (
  $ensure       = 'present',
  $classes      = {},
  $hiera_merge  = true,
) {

  # Validate $ensure is either 'present' or 'absent'
  validate_re($ensure, ['present', 'absent'], "ensure must be either 'present' or 'absent'")

  # Validate classes is a hash
  validate_hash($classes)

  # Validate hiera_marge is a boolean
  validate_bool($hiera_merge)

  # Hiera-merge classes hash
  if $hiera_merge == true {
    $classes_real = hiera_hash('loader::classes', {})
  } else {
    $classes_real = $classes
  }

  # Iterate class loading using defined resource types
  $class_names = keys($classes_real)
  if $ensure == 'present' {
    loader::load { $class_names :
      classes => $classes_real,
    }
  }
}

