$SiteUrl = "https://cowelljp.sharepoint.com/sites/SPO07"
$SiteUser = "CwThanhNH@cowelljp.onmicrosoft.com"

$PassWord = ConvertTo-SecureString "Bean101500" -AsPlainText -Force

$CredInfo = New-Object System.Management.Automation.PSCredential($SiteUser, $PassWord)
			Write-Host "Connecting... to site:"$SiteUrl -f Green
			Connect-PnPOnline $SiteUrl -Credentials $CredInfo -WarningAction Ignore
			Write-Host "Connected" -f Green

$ListName = "PnpRegistractionDetail"	   
New-PnPList -Title $ListName -Template GenericList

Try {          
	# Rename List
	$FieldName = '<Field Type="Text" DisplayName="Full Name" Required="TRUE" MaxLength="255" Name="FullName"/>'              
	Add-PnPFieldFromXml -FieldXml $FieldName -List $ListName

	$FieldAge = '<Field
			Type="Number"
			Name="Age"
			DisplayName="Age"
			Required="TRUE"
			Description=""
			Min="0"
			Max="200"
			>
		</Field>'
	Add-PnPFieldFromXml -FieldXml $FieldAge -List $ListName

	$FiledDayOfBirth = '<Field
		Type="DateTime"
		DisplayName="Day Of Birth"
		Format="DateTime"
		Required="TRUE"		
		Name="DayOfBirth">
	</Field>'
	Add-PnPFieldFromXml -FieldXml $FiledDayOfBirth -List $ListName

	$FieldEmail = '<Field Type="Text" DisplayName="Email" Required="TRUE" MaxLength="255" Name="Email"/>'
	Add-PnPFieldFromXml -FieldXml $FieldEmail -List $ListName


	$FieldPhoneNumber = '<Field Type="Text" DisplayName="Phone Number" Required="TRUE" MaxLength="255" Name="PhoneNumber"/>'
	Add-PnPFieldFromXml -FieldXml $FieldPhoneNumber -List $ListName

	$FieldAddress = '<Field
		Type="Note"		
		Name="Address"
		DisplayName="Address"
		NumLines="6"
		Required="TRUE">
	    </Field>'
	Add-PnPFieldFromXml -FieldXml $FieldAddress -List $ListName

	$FieldPicture = '<Field Type="Image" DisplayName="Picture" Required="TRUE" Name="Picture" ></Field>'
	Add-PnPFieldFromXml -FieldXml $FieldPicture -List $ListName

	$FieldTShirtSize = '<Field Type="MultiChoice" DisplayName="T-Shirt Size" Required="TRUE" Format="Checkboxes" FillInChoice="FALSE" Name="TShirtSize">
		<Default> XS </Default>
		<CHOICES>
			<CHOICE>XS </CHOICE>
			<CHOICE>S </CHOICE>
			<CHOICE>M </CHOICE>  
			<CHOICE>L </CHOICE>
			<CHOICE>XL </CHOICE>
			<CHOICE>XXL </CHOICE>
		</CHOICES>
		</Field>'
	Add-PnPFieldFromXml -FieldXml $FieldTShirtSize -List $ListName

	$FieldPaymentMethod = '<Field Type="Choice" DisplayName="Payment Method" Required="TRUE" Format="Dropdown" Name="PaymentMethod">
		<Default> Cash </Default>
		<CHOICES>
			<CHOICE>Cash </CHOICE>
			<CHOICE>Credit Card </CHOICE>
			<CHOICE>Check </CHOICE>
			
			<CHOICE>PayPal </CHOICE>
			<CHOICE>Bank Transfer </CHOICE>
		</CHOICES>
		</Field>'
	Add-PnPFieldFromXml -FieldXml $FieldPaymentMethod -List $ListName

	$FiledRegisterFee = '<Field Type="Choice" DisplayName="RegistrationFee" Required="TRUE" Format="RadioButtons"  Name="TShirtSize">
		<Default> 3K run $20 </Default>
		<CHOICES>
			<CHOICE>3K run $20 </CHOICE>
			<CHOICE>5K run $30 </CHOICE>
			<CHOICE>10K run $40 </CHOICE>  
        </CHOICES>
        </Field>'	
	Add-PnPFieldFromXml -FieldXml $FiledRegisterFee -List $ListName

	Set-PnPList -Identity "PnpRegistractionDetail" -Title "Pnp Registraction Detail" 

	Write-Host "Done" -f Green                 	         
     
}
Catch {
	write-host -f Red "Error Creating List!" $_.Exception.Message   
}



