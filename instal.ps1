$User = '.\backup'
$Password = '@skrUpuF646'
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $SecurePassword
#New-Service -Name 'kopia2' -BinaryPathName '"C:\Users\Gcomp\GolandProjects\kopia\kopia.exe" --config-file="C:\Users\Gcomp\GolandProjects\kopia\repository.config" server start --insecure --htpasswd-file="C:\Users\Gcomp\GolandProjects\kopia\pwd" --server-username=admin@localhost --password=301180 --enable-actions' -DisplayName 'kopia'  -StartupType Automatic
New-Service -Name 'kopia3' -BinaryPathName '"C:\Users\Gcomp\GolandProjects\kopia\kopia.exe" --config-file="C:\Users\Gcomp\GolandProjects\kopia\repository.config" server start --insecure  --server-username=admin@localhost --password=301180 --enable-actions' -DisplayName 'kopia3'  -StartupType Automatic