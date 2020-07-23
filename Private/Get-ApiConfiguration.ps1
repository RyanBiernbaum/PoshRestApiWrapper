
function Get-ApiConfiguration {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true,Position=0)] [ValidateNotNullOrEmpty()] [string] $ApiName
    )
    try {
        Write-Output $Script:ApiConfig.Item( $ApiName )
    }
    catch {
        $ErrorParam = @{
            Exception      = $_.Exception
            Category       = [System.Management.Automation.ErrorCategory]::InvalidArgument
            CategoryReason = "No configuration exists for '$ApiName'"
            RecommendedAction = "Set configuration using 'Set-ApiConfiguration'"
        }
        Write-Error @ErrorParam -ErrorAction Stop
    }
}