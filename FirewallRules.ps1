#This will help change Windows Firewall Rules much faster than going through the GUI. Keep in mind, there's no input checking and this was built for simple ease of use. 
#******************************************************************
#******************************************************************
#**                                                              **
#**                      Firewall Rules                          **
#**                    Written by: Z3R0th                        **
#**                                                              **
#**                                                              **
#******************************************************************
#******************************************************************

#Sets Protocol to TCP if TCP is selected.
function TCP-Rule {
    $Protocol = "TCP"
}

#Sets Protocol to UDP if UDP is selected
function UDP-Rule {
    $Protocol = "UDP"
}

#Sets Protocol to both TCP and UDP if selected
function Both-Rule {
#Checks user input to ensure proper values were assigned.
Write-Host "
+-------------++-------------------------++------------------------------------------------------+
| Name        ||  Description            || Your Input
+-------------++-------------------------++------------------------------------------------------+
| DisplayName ||  The Display Name       || $DisplayName 
| Direction   ||  Inbound or Outbound    || $Direction
| Description ||  Description of Rule    || $Description
| Enabled     ||  Active or not          || $Enabled
| Action      ||  Allow or deny          || $Action
| Protocol    ||  TCP or UDP             || $Protocol
| LocalPort   ||  Port for Rule          || $LocalPort
+-------------++-------------------------++------------------------------------------------------+ 
"
#Reiterating upon the above box.
$Answer = Read-Host -Prompt "Alright, does everything look right to you?"
    If (( $Answer -eq "n" ) -or ( $Answer -eq "no" ) -or ( $Answer -eq "N" ) -or ( $Answer -eq "No" )) {
        exit
    }
    If (($Answer -eq "y" ) -or ($Answer -eq "yes" ) -or ($Answer -eq "Y" ) -or ($Answer -eq "Yes" )) {
        New-NetFirewallRule -DisplayName "$DisplayName for TCP" -Direction "$Direction" -Action "$Action" -Enabled "$Enabled" -Description "$Description for TCP" -LocalPort "$LocalPort" -Protocol "TCP"
        New-NetFirewallRule -DisplayName "$DisplayName for UDP" -Direction "$Direction" -Action "$Action" -Enabled "$Enabled" -Description "$Description for UDP" -LocalPort "$LocalPort" -Protocol "UDP"
        exit
    }
}

Function Invoke-FirewallRules {

clear
echo ""

Write-Host "
    _______                         ____   ____        __         
   / ____(_)_______ _      ______ _/ / /  / __ \__  __/ /__  _____
  / /_  / / ___/ _ \ | /| / / __ ` / / /  / /_/ / / / / / _ \/ ___/
 / __/ / / /  /  __/ |/ |/ / /_/ / / /  / _, _/ /_/ / /  __(__  ) 
/_/   /_/_/   \___/|__/|__/\__,_/_/_/  /_/ |_|\__,_/_/\___/____/  
                                                                 
" 
echo ""

#Defines what you want the Firewall Rule named. 
$DisplayName = Read-Host -Prompt "What would you like to name this Firewall Rule?" 
echo ""

#Defines whether or not the rule will apply to Inbound or Outbound traffic
$Direction = Read-Host -Prompt "Would you like this to be Inbound or Outbound?"
    if (( $Direction -eq "Inbound" ) -or ( $Direction -eq "in" ) -or ( $Direction -eq "In" ) -or ( $Direction -eq "inbound" )) {
        $Direction = "Inbound"
    }
    if (( $Direction -eq "Outbound" ) -or ( $Direction -eq "out" ) -or ( $Direction -eq "Out" ) -or ($Direction -eq "outbound" )) {
        $Direction = "Outbound"
    }
    if (( $Direction -eq $null ) -or ( $Direction -eq "") -or ( $Direction -eq " " )) {
        Write-Host "You entered a null value. This is not acceptable." ; exit
    }
echo ""

#Defines whether or not you would like to enter in a description for your rule. I would recommend doing so to prevent confusion in the future.
$Description = Read-Host -Prompt "Would you like to enter a description for your Firewall Rule?" 
    if (( $Description -eq "y" ) -or ( $Description -eq "yes" ) -or ( $Description -eq "Y" ) -or ( $Description -eq "Yes" )) {
        $Description = Read-Host -Prompt "Please enter the description here"
    }
    if (( $Description -eq "n" ) -or ( $Description -eq "no" ) -or ( $Description -eq "N" ) -or ( $Description -eq "No" )) {
        $Description = $null
    }
echo ""

#Defines whether or not you wish to have this rule go into effect immediately or if you would like to build it but have not not be active.
$Enabled = Read-Host -Prompt "Would you like to enable this rule now? [ Y / N ]"
    if (( $Enabled -eq "Y" ) -or ( $Enabled -eq "Yes" ) -or ( $Enabled -eq "y" ) -or ( $Enabled -eq "yes" )) {
        $Enabled = "True"
    }
    if (($Enabled -eq "n" ) -or ($Enabled -eq "no" ) -or ($Enabled -eq "N" ) -or ($Enabled -eq "No" )) {
       $Enabled = "False"
    }
    if (( $Enabled -eq $null ) -or ( $Enabled -eq "") -or ( $Enabled -eq " " )) {
        Write-Host "You entered a null value. This is not acceptable." ; exit 
    }
echo ""

#Defines whether or not you would like to let traffic through or block. 
$Action = Read-Host -Prompt "Would you like to Allow or Block this traffic?"
    if (( $Action -eq "allow" ) -or ( $Action -eq "Allow" )) {
        $Action = "allow"
    }
    if (( $Action -eq "block" ) -or ( $Action -eq "Block" )) {
        $Action = "Block"
    }
echo ""

#Defines the port that this Firewall Rule applies to
$LocalPort = Read-Host -Prompt "What port would you like this to be on?"
echo ""

$Protocol = Read-Host -Prompt "Do you want this to be TCP, UDP, or Both?"
    if (( $Protocol -eq "TCP" ) -or ( $Protocol -eq "tcp" )) {
        TCP-Rule
    }
    if (( $Protocol -eq "UDP" ) -or ( $Protocol -eq "udp" )) {
        UDP-Rule
    }
    if (( $Protocol -eq "Both" ) -or ( $Protocol -eq "both" )) {
        Both-Rule
    }
echo ""

#Checks user input to ensure proper values were assigned.
Write-Host "
+-------------++-------------------------++------------------------------------------------------+
| Name        ||  Description            || Your Input
+-------------++-------------------------++------------------------------------------------------+
| DisplayName ||  The Display Name       || $DisplayName 
| Direction   ||  Inbound or Outbound    || $Direction
| Description ||  Description of Rule    || $Description
| Enabled     ||  Active or not          || $Enabled
| Action      ||  Allow or deny          || $Action
| Protocol    ||  TCP or UDP             || $Protocol
| LocalPort   ||  Port for Rule          || $LocalPort
+-------------++-------------------------++------------------------------------------------------+ 
"
#Reiterating upon the above box.
$Answer = Read-Host -Prompt "Alright, does everything look right to you?"
    If (( $Answer -eq "n" ) -or ( $Answer -eq "no" ) -or ( $Answer -eq "N" ) -or ( $Answer -eq "No" )) {
        exit
    }
    If (($Answer -eq "y" ) -or ($Answer -eq "yes" ) -or ($Answer -eq "Y" ) -or ($Answer -eq "Yes" )) {
        New-NetFirewallRule -DisplayName "$DisplayName" -Direction "$Direction" -Action "$Action" -Enabled "$Enabled" -Description "$Description" -LocalPort "$LocalPort" -Protocol "$Protocol"
    }
}


#Runs the command.
Invoke-FirewallRules
