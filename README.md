# Unencrypted LDAP Binds
Get Active Directory unencrypted LDAP binds

Active Directory Domain Controllers uses three protocols for authentication: Kerberos, NTLM and LDAP. For Windows native applications usually first two are used. They are secured by encryption. LDAP protocol authentication is used usually by non-native apps like Java. By default configuration Windows domain controller allows unencrypted LDAP binding. That means all messages are sent in clear text including login and password.
You could change time inside the script from last 24 hours.

You could configure Event Log to store every such binding:
1. Open registry editor on domain controller
   > HKLM\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics
1. Change `16 LDAP Interface Events` value to **2**
1. You could see Event ID `2889` pops up in
   > Event Viewer -> Applications and Services Logs -> Directory service
   
Edit the script and supply your
1. LDAPBINDS\PATH.HTML for HTML file.
1. FROMEMAIL@ADDRESS, TOEMAIL@ADDRESS and MAIL.SERVER to send generated email

You may need to increase Maximum log size in order to accomodate all events comming to it after you enabled Active Directory Diagnostic Event Logging.
