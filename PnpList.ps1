$SiteUrl = "https://cowelljp.sharepoint.com/sites/SPO07"
$SiteUser = "CwDemo@cowelljp.onmicrosoft.com"

$PassWord = ConvertTo-SecureString "Training123" -AsPlainText -Force

$CredInfo = New-Object System.Management.Automation.PSCredential($SiteUser, $PassWord)
			Write-Host "Connecting... to site:"$SiteUrl -f Green
			Connect-PnPOnline $SiteUrl -Credentials $CredInfo -WarningAction Ignore
			Write-Host "Connected" -f Green
# Function check if List Exists
function CheckExistsField($FieldCheck , $ListCheck){
    Write-Host $FieldCheck -f Blue
    $FieldName = Get-PnPField -List $ListCheck -Identity $FieldCheck
    Write-Host $FieldName.Title 
    if($FieldName.Title -eq $FieldCheck){
        Write-Host $FieldCheck " exists" -f Blue
    }
    else{
        Write-Host $FieldCheck " not exists" -f Red
    }
}

try {
    $ListName = "Lst_Pnp_Demo"		
    $List = Get-PnPList -Identity $ListName
    
    If ($List.Title -eq $ListName) {  
       # Write-Host $listTitle " - List exist!"
       $Vari = "PnpLocation"
       CheckExistsField -FieldCheck $Vari -ListCheck $ListName 
    }

    ELSE {
        #Create a List name demo
        New-PnPList -Title $ListName -Template GenericList
			
        #Create a column name Location of Text
        Add-PnPField -List $ListName -DisplayName "PnpLocation" -InternalName "PnpLocation" -Type Text
			
        $FieldXml = '<Field Type="Text" DisplayName="Pnp Demo Name" Required="TRUE" MaxLength="255" Name="PnpDemoName" Description="Pnp Name for the Demo" />'
        Add-PnPFieldFromXml -FieldXml $FieldXml -List $ListName
		CheckExistsField("PnpLocation",$ListName)	
        Write-Host "Done" -f Green
       # Write-Host $listTitle " - List not exist!"  
    }
}
catch {
    Write-Host"erorr!!!" -f Blue
    #{ 1:<#Do this if a terminating exception happens#> }
}