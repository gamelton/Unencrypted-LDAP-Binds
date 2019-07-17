$XML1 = '<QueryList><Query><Select Path="Directory Service">*[System[(EventID=2889) and TimeCreated[timediff(@SystemTime) &lt;= 86400000]]]</Select></Query></QueryList>'

$binds = Get-WinEvent -FilterXml $XML1

$bindsreport=@()
foreach($bind in $binds){$IP = $bind.Properties[0].Value; $User=$bind.Properties[1].Value; $Time = $bind[0].TimeCreated; $obj = [PSCustomObject]@{IP = $IP; User = $User; Time = $Time};$bindsreport += $obj}
