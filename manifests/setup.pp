define users::setup($hash) {
  if(!defined(User[$name])) {
    if ($hash[$name]['home']) {
      $home = $hash[$name]['home']
    } else {
      $home = "/home/$name"
    }
    user { $name :
      allowdupe => $hash[$name]['allowdupe'],
      attribute_membership => $hash[$name]['attribute_membership'],
      attributes => $hash[$name]['attributes'],
      auth_membership => $hash[$name]['auth_membership'],
      auths => $hash[$name]['auths'],
      comment => $hash[$name]['comment'],
      ensure => $hash[$name]['ensure'],
      expiry => $hash[$name]['expiry'],
      gid => $hash[$name]['gid'],
      groups => $hash[$name]['groups'],
      home => $hash[$name]['home'],
      ia_load_module => $hash[$name]['ia_load_module'],
      key_membership => $hash[$name]['key_membership'],
      keys => $hash[$name]['keys'],
      managehome => $hash[$name]['managehome'],
      membership => $hash[$name]['membership'],
      password => $hash[$name]['password'],
      password_max_age => $hash[$name]['password_max_age'],
      password_min_age => $hash[$name]['password_min_age'],
      profile_membership => $hash[$name]['profile_membership'],
      profiles => $hash[$name]['profiles'],
      project => $hash[$name]['project'],
      provider => $hash[$name]['provider'],
      role_membership => $hash[$name]['role_membership'],
      roles => $hash[$name]['roles'],
      shell => $hash[$name]['shell'],
      system => $hash[$name]['system'],
      uid => $hash[$name]['uid'],
    } ->
    file { $home:
      ensure => "directory",
      owner => $name,
      group => $name,
      mode => "0755",
    } ->
    file { "$home/.ssh":
      ensure => "directory",
      owner => $name,
      group => $name,
      mode => "0700",
    } ->
    file { "$home/.ssh/authorized_keys":
      ensure  => present,
      owner   => $name,
      group   => $name,
      mode    => '0600',
    }

    if($hash[$name]['ssh_authorized_keys']) {
      $_sshkey = $hash[$name]['ssh_authorized_keys']
      if(is_hash($_sshkey)) {
        $_sshkeys = keys($_sshkey)
        users::ssh_authorized_keys { $_sshkeys:
          hash => $_sshkey,
          user => $name,
          before => File["$home/.ssh/authorized_keys"],
        }
      } else {
          notify { "user ssh key data for ${name} must be in hash form": }
      }
    }
  }
}
