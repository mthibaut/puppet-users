define users::ssh_authorized_keys($user, $hash) {
 
    if(!defined(Ssh_authorized_keys[$user])) {
	ssh_authorized_key { "${user}-${name}" :
	    ensure   => $hash[$name]['ensure'],
	    key      => $hash[$name]['key'],
	    options  => $hash[$name]['options'],
	    provider => $hash[$name]['provider'],
	    target   => $hash[$name]['target'],
	    type     => $hash[$name]['type'],
	    user     => $user,
	}
    }

}
