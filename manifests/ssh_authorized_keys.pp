define users::ssh_authorized_keys($user, $hash, $h_key) {
  if(!defined(Ssh_authorized_keys[$user])) {
    ssh_authorized_key { "${user}-${h_key}" :
      ensure   => $hash["$h_key"]['ensure'],
      key      => $hash["$h_key"]['key'],
      options  => $hash["$h_key"]['options'],
      provider => $hash["$h_key"]['provider'],
      target   => $hash["$h_key"]['target'],
      type     => $hash["$h_key"]['type'],
      user     => $user,
    }
  }
}
