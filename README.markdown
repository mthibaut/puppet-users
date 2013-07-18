users
====

[![Build Status](https://travis-ci.org/mthibaut/puppet-users.png?branch=master)](https://travis-ci.org/mthibaut/puppet-users)


Overview
--------

The users module allows management of user accounts through hiera or a
hash of directly specified users.

Module Description
-------------------

Normally each user needs to be specified inside a puppet manifest. This module allows you to specify the users outside of puppet, so that the user setup can become variable.

Setup
-----

### Configure your users in hiera

        common.yaml:

        ---
        users_sysadmins:
            john:
                ensure: present
                uid: 1000
                gid: staff
                groups: - wheel
                comment: John Doe
                managehome: true
                ssh_authorized_keys:
                        mykey:
                               	type: 'ssh-rsa'
                               	key:  'mykeydata=='

All parameters to the standard types 'user' and 'ssh_authorized_key' can be used.

### Include users in your manifest

        site.pp:

        node /default/ {
            users { sysadmins: }
        }

Usage
------

The name given to the users type will be used to lookup 'users_$name' inside
hiera. Alternatively you can specify the hash directly without hiera, see
below.

The defined type *users* can be called with two arguments:

###`match`

Defaults to 'all'. Can be 'all', 'any' (sysonym for 'all'), or 'first'.

If 'first' is used, then only the first match in your hiera hierarchy will be used. If you specify 'all' then all matching hashes will be be used. This corresponds directly to the respective 'hiera' and 'hiera_hash' function calls.

###`hash`

Defaults to undef. Uses the given hash rather than the result of the hiera lookup.

Troubleshooting
---------------

Before blaming me, check if your hiera configuration is working correctly. For instance, you can use this to check if puppet is seeing your hiera data correctly:

        node /mynode/ {
                $mytest = hiera("users_sysadmins", "not found")
                notify { "$mytest": }
        }


Dependencies
------------

* In puppet 3.0.0, hiera became a standard function call so it is included by default in your puppet installation. Before 3.0.0, you must install the hiera-puppet module.

* stdlib
