$User = '.\backup'
$Password = '@skrUpuF646'
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $SecurePassword
New-Service -Name 'kopia-slava-1' -BinaryPathName '"C:\Program Files\kopia\kopia.exe" --config-file="C:\Program Files\kopia\repository.config" server start --insecure --htpasswd-file="C:\Program Files\kopia\pwd" --server-username=admin@localhost --password=301180 --enable-actions' -DisplayName 'kopia-slava-1' -Credential $Credential -StartupType Automatic
#New-Service -Name 'kopia5' -BinaryPathName '"C:\Users\Gcomp\GolandProjects\kopia\kopia.exe" server start --insecure --without-password --disable-csrf-token-checks --enable-actions' -DisplayName 'kopia5'  -StartupType Manual