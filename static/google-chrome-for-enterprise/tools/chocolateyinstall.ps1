
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

  checksum      = 'F0E0664A0BC00AFA4B4FEFF623A0B88AF3D246065034FB3C8282CF78F226E109'
  checksumType  = 'sha256'
  checksum64    = '44B856B5C2D3FB16764183944915B90F349E404ED1AC05AFE609C32A8DC59D4E'
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
