
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.google.com/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi'
$url64      = 'https://dl.google.com/edgedl/chrome/install/GoogleChromeStandaloneEnterprise64.msi'
$master_preferences = $(Join-Path $toolsDir 'master_preferences')

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64

  softwareName  = 'Google Chrome*'

  checksum      = '8565E6089305C31290A81ECFAB1D86D9877BE1F441A28AB732914D682B423893'
  checksumType  = 'sha256'
  checksum64    = 'C646EB8BC42A3A9BA879AE91609BFFF557EF711EC1A49BC0A59A434D2843E6A5'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

$master_preferences = @"
{
  "browser": {
    "show_home_button": true
  },
  "sync_promo": {
    "show_on_first_run_allowed": false
  },
  "distribution": {
    "suppress_first_run_bubble": true,
    "do_not_create_desktop_shortcut": false,
    "do_not_create_quick_launch_shortcut": true,
    "do_not_launch_chrome": true,
    "do_not_register_for_update_launch": true,
    "make_chrome_default": false,
    "make_chrome_default_for_user": false,
    "suppress_first_run_default_browser_prompt": true,
    "system_level": true,
    "verbose_logging": true
  }
}
"@

 $master_preferences | Out-File "${env:ProgramFiles(x86)}\Google\Chrome\Application\master_preferences"
