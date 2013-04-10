class other {
  $packages = ["curl", "vim", "emacs", "git-core", "tmux", "augeas-tools", "libaugeas-dev", "libaugeas-ruby"]
  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  notify { "Misc packages installed" : }
}
