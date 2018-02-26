Import-Module WebAdministration

$user = Read-host "Username"
$pass = Read-host "Password" 

$applicationPools = Get-ChildItem IIS:\AppPools | where { $_.processModel.userName -ieq $user }

foreach($appPool in $applicationPools)
{
    $appPool | Set-ItemProperty -Name processModel.userName -Value $user
    $appPool | Set-ItemProperty -Name processModel.password -Value $pass
    $appPool | Set-ItemProperty -Name processModel.identityType -Value 3
	
	Restart-WebAppPool $appPool.name
	
    Write-Host "IIS:\AppPools\$($appPool.name) --- Updated!" -ForegroundColor Green
}

Write-Host "All Application pool passwords were updated..." -ForegroundColor Magenta 
Write-Host ""