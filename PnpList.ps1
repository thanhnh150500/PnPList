$SiteUrl = "https://cowelljp.sharepoint.com/sites/SPO07"
$SiteUser = "CwDemo@cowelljp.onmicrosoft.com"

$PassWord = ConvertTo-SecureString "Training123" -AsPlainText -Force

$CredInfo = New-Object System.Management.Automation.PSCredential($SiteUser, $PassWord)
			Write-Host "Connecting... to site:"$SiteUrl -f Green
			Connect-PnPOnline $SiteUrl -Credentials $CredInfo -WarningAction Ignore
			Write-Host "Connected" -f Green
			
$ListName = "PnpRegistrationDetails"			
			
            #Create a List name demo
			New-PnPList -Title $ListName -Template GenericList
			
			#Create a column name Location of Text
			Add-PnPField -List $ListName -DisplayName "PnpLocation" -InternalName "PnpLocation" -Type Text
			
			$FieldXml = '<Field Type="Text" DisplayName="Pnp Demo Name" Required="TRUE" MaxLength="255" Name="PnpDemoName" Description="Pnp Name for the Demo" />'
			Add-PnPFieldFromXml -FieldXml $FieldXml -List $ListName
			
            Write-Host "Done" -f Green