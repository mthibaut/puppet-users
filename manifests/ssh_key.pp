define users::ssh_key($hash, $user) {
	ssh_authorized_key { $name:
		  ensure => $hash[$name]['ensure'],
		  key => $hash[$name]['key'],
		  user => $user,
		  type => $hash[$name]['type'],
		  name => $name
			
	}
}
