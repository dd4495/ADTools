Function Set-NewADPassword {
<#
  .SYNOPSIS
  Describe the function here
  .DESCRIPTION
  Describe the function in more detail
  .EXAMPLE
  Give an example of how to use it
  .EXAMPLE
  Give another example of how to use it
  .PARAMETER computername
  The computer name to query. Just one.
  .PARAMETER logname
  The name of a file to write failed computer names to. Defaults to errors.txt.
  #>
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True,HelpMessage="Which user's password are you changing?")]
    [string]$Username,
    [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True,HelpMessage="What is the new password?")]
    [ValidateLength(8, 64)]
    [ValidateScript({
        if ($_ -cnotmatch '[A-Z]') {Throw "Password requires at least one uppercase letter"}
        elseif ($_ -cnotmatch '[a-z]') {Throw "Password requires at least one lowercase letter"}
        elseif ($_ -cnotmatch '[0-9]') {Throw "Password requires at least one number"}
        else {$true}
    })]
    [string]$Password
  )

$SecureString=ConvertTo-SecureString -string $Password -AsPlainText -Force
Set-ADAccountPassword -Identity $Username -Reset -NewPassword $SecureString
}