class sshd {

    package { 'openssh-server':
        ensure => latest
    }

    service { 'ssh':
        subscribe => File[sshdconfig],
        require => [
            Package['openssh-server'],
            Augeas["sshd_config"],
        ],
    }

    augeas { "sshd_config":
        require => [
            Package["augeas-tools"],
            Package["libaugeas-dev"],
            Package["libaugeas-ruby"],
        ],
        context => "/files/etc/ssh/sshd_config",
        changes => [
            "set PermitRootLogin no",
        ],
    }

    file { 'sshdconfig':
        name => '/etc/ssh/sshd_config',
        owner => root,
        group => root,
        mode => 644,
        require => Package['openssh-server'],
    }
}