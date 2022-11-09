# Fill in your domain username, password and e-mail address of account to search for
# You can examine json extract and see what AD attributes are there and use them for further searches
# by modifiying .filter attribute

$queryString = (New-Object System.DirectoryServices.DirectoryEntry ("LDAP://RootDSE")).Properties["defaultNamingContext"][0]
$queryString = "LDAP://" + $queryString

$dn = New-Object System.DirectoryServices.DirectoryEntry ($queryString, "<USERNAME>", "<PASSWORD>")

$user2Find = "<email address of user to search for>"
$Rech = new-object System.DirectoryServices.DirectorySearcher($dn)
$Rech.filter = "((mail=$user2Find))"
$Rech.SearchScope = "subtree"

$theUser = $Rech.FindOne();

if ($theUser)
{
  $theUser.Properties | ConvertTo-Json | Out-File ($user2Find + ".json")
}
else
{
  "User $user2Find not found!"
}