#=Main Puppet Manifest

#Update Apt Repo
exec{"update-apt":
	command => "apt-get update",
	cwd 	=> "/",
	path 	=> ["/usr/bin", "/usr/local/bin", "/bin", "/usr/local/sbin", "/usr/sbin", "/sbin"],
}

#Install python-virtualenv
package{"python-virtualenv":
	ensure  => present,
	require => Exec["update-apt"],
}

#Install virtualenvwrapper
package{"virtualenvwrapper":
	ensure => present,
	require => Exec["update-apt"],
}

#Install git
package{"git":
	ensure  => present,
	require => Exec["update-apt"],
}

#Install mcom-tests
exec{"install_mcom":
	command  => "git clone https://github.com/mozilla/mcom-tests.git",
	cwd 	 => "/home/vagrant/mozilla-projects",
	path     => ["/usr/bin", "/usr/local/bin", "/bin", "/usr/local/sbin", "/usr/sbin", "/sbin"],
}
