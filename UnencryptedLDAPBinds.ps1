$XML1 = '<QueryList><Query><Select Path="Directory Service">*[System[(EventID=2889) and TimeCreated[timediff(@SystemTime) &lt;= 86400000]]]</Select></Query></QueryList>'

$binds = Get-WinEvent -FilterXml $XML1

$bindsreport=@()
foreach($bind in $binds){$IP = $bind.Properties[0].Value.Split(":")[0]; $User=$bind.Properties[1].Value; $Time = $bind[0].TimeCreated; $obj = [PSCustomObject]@{IP = $IP; User = $User; Time = $Time};$bindsreport += $obj}

$uniqnames = $bindsreport | Group-Object 'User', 'IP' | foreach { $_.Group | Select 'User','IP','Time' -First 1} | Sort 'User','IP' 

if($uniqnames){
$uniqnames | ConvertTo-Html -body "<H2>LDAP unencrypted binds to DC</H2>" | Out-File LDAPBINDS\PATH.HTML
$FHuniqnames = [System.IO.File]::ReadAllText('LDAPBINDS\PATH.HTML')
$EmailBody = "<p>Below are LDAP simple binds over last 24 hours.</p>
$FHuniqnames"
Send-MailMessage  –From "FROMEMAIL@ADDRESS" –To "TOEMAIL@ADDRESS" –Subject "Unencrypted LDAP binds report $(Get-Date -Format "yyyy-MM-dd")" -Body $EmailBody -BodyAsHtml –SmtpServer MAIL.SERVER
Remove-Item 'LDAPBINDS\PATH.HTML'
}
