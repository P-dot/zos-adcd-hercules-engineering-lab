$cfg  = 'F:\ZOS111\hercules.cnf'
$bak  = 'F:\ZOS111\hercules.cnf.BEFORE_SBSYS9'
$line = '0A9D 3390 F:\ZOS111\SBSYS9.CCKD'

Copy-Item $cfg $bak -Force

$c = Get-Content $cfg

if ($c -match '^\s*0A9D\s+') {
    $c = $c -replace '^\s*0A9D\s+.*$', $line
}
elseif ($c -match '^\s*0A9C\s+') {
    $out = @()
    foreach ($l in $c) {
        $out += $l
        if ($l -match '^\s*0A9C\s+') {
            $out += $line
        }
    }
    $c = $out
}
else {
    $c += $line
}

Set-Content -Path $cfg -Value $c -Encoding ASCII

Select-String -Path $cfg -Pattern '^\s*0A9C\s+|^\s*0A9D\s+'
