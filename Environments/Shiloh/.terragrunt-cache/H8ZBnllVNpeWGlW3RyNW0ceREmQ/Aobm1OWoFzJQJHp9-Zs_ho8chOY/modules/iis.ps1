<powershell>
# Install Web-Server feature with management tools
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
#Restart machine
shutdown -r -t 10;
</powershell>