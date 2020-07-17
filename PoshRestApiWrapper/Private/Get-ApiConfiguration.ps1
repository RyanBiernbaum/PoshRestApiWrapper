
function Get-ApiConfiguration {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true,Position=0)] [string] $ApiName
    )
    if( -not $Script:ApiConfig.ContainsKey($ApiName) ) {
        throw "No configuration for exists '$ApiName'. Set configuration using 'Set-ApiConfiguration'"
    }
    Write-Output $Script:ApiConfig[$ApiName]
}