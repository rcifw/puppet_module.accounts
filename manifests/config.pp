# Global accounts configuration
class accounts::config(
  Hash $options = {}
) {

  if 'umask' in $options {
    $umask = $options['umask']
    augeas {'Set umask':
      incl    => '/etc/login.defs',
      lens    => 'Login_Defs.lns',
      changes => [
        "set UMASK ${umask}",
      ],
    }
  }

  if 'first_uid' in $options {
    case $::osfamily {
      'Debian': {
        shellvar { 'FIRST_UID':
          ensure => present,
          target => '/etc/adduser.conf',
          value  => $options['first_uid'],
        }
      }
      'RedHat': {
        augeas {'Set first uid':
          incl    => '/etc/login.defs',
          lens    => 'Login_Defs.lns',
          changes => [
            "set UID_MIN ${options['first_uid']}",
          ],
        }
      }
      default: {
        fail("I don't know how to set first UID on osfamily ${::osfamily}")
      }
    }
  }

  if 'last_uid' in $options {
    case $::osfamily {
      'Debian': {
        shellvar { 'LAST_UID':
          ensure => present,
          target => '/etc/adduser.conf',
          value  => $options['last_uid'],
        }
      }
      'RedHat': {
        augeas {'Set last uid':
          incl    => '/etc/login.defs',
          lens    => 'Login_Defs.lns',
          changes => [
            "set UID_MAX ${options['last_uid']}",
          ],
        }
      }
      default: {
        fail("I don't know how to set last UID on osfamily ${::osfamily}")
      }
    }
  }

  if 'first_gid' in $options {
    case $::osfamily {
      'Debian': {
        shellvar { 'FIRST_GID':
          ensure => present,
          target => '/etc/adduser.conf',
          value  => $options['first_gid'],
        }
      }
      'RedHat': {
        augeas {'Set first gid':
          incl    => '/etc/login.defs',
          lens    => 'Login_Defs.lns',
          changes => [
            "set GID_MIN ${options['first_gid']}",
          ],
        }
      }
      default: {
        fail("I don't know how to set first GID on osfamily ${::osfamily}")
      }
    }
  }

  if 'last_gid' in $options {
    case $::osfamily {
      'Debian': {
        shellvar { 'LAST_GID':
          ensure => present,
          target => '/etc/adduser.conf',
          value  => $options['last_gid'],
        }
      }
      'RedHat': {
        augeas {'Set last gid':
          incl    => '/etc/login.defs',
          lens    => 'Login_Defs.lns',
          changes => [
            "set GID_MAX ${options['last_gid']}",
          ],
        }
      }
      default: {
        fail("I don't know how to set last GID on osfamily ${::osfamily}")
      }
    }
  }

}