# @summary Default values
# @api private
class globus::params {

  case $::osfamily {
    'RedHat': {
      if $::operatingsystem == 'Fedora' {
        $repo_descr   = 'Globus-Toolkit-6-fedora'
        $repo_baseurl = 'https://downloads.globus.org/toolkit/gt6/stable/rpm/fedora/$releasever/$basearch/'
        $yum_priorities_package = 'yum-plugin-priorities'
      } else {
        $repo_descr   = "Globus-Toolkit-6-el${::operatingsystemmajrelease}"
        if $::operatingsystem == 'RedHat' {
          $releasever = $::operatingsystemmajrelease
        } else {
          $releasever = "\$releasever"
        }
        $repo_baseurl = "https://downloads.globus.org/toolkit/gt6/stable/rpm/el/${releasever}/\$basearch/"

        if versioncmp($::operatingsystemmajrelease, '6') >= 0 {
          $yum_priorities_package = 'yum-plugin-priorities'
        } else {
          fail("Unsupported operatingsystemmajrelease: ${::operatingsystemmajrelease} for ${::operatingsystem}, only supports 6 and 7.")
        }
      }

      $release_url = 'https://downloads.globus.org/toolkit/globus-connect-server/globus-connect-server-repo-latest.noarch.rpm'
      $gpg_key_url = 'https://downloads.globus.org/toolkit/gt6/stable/repo/rpm/RPM-GPG-KEY-Globus'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
