
function Invoke-ApiMethod {
    [CmdletBinding(DefaultParameterSetName='StoredConfig',PositionalBinding=$false,SupportsShouldProcess,ConfirmImpact='Low')]
    [OutputType([PSObject])]
    param(
        [Parameter(Mandatory=$true,ParameterSetName='StoredConfig',Position=0)] [string] $ApiName,
        [Parameter(ParameterSetName='StoredConfig')] [switch] $PaginatedEndpoint = $false,
        [Parameter(ParameterSetName='StoredConfig')] [int] [ValidateRange(1,[int]::MaxValue)] $MaximumPages = 10,
        [Parameter(Mandatory=$true,ParameterSetName='Ad-Hoc')] [uri] $BaseUri,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName)] [string] $Path,
        [Parameter(ValueFromPipelineByPropertyName)] [hashtable] $Query = @{ },
        [Parameter(ValueFromPipelineByPropertyName)] [psobject] $Body,
        [Parameter()] [Microsoft.PowerShell.Commands.WebRequestMethod] $Method = 'Get',
        [Parameter()] [hashtable] $Headers = @{ },
        [Parameter()] [hashtable] $ExtraRestParameters = @{ },
        [Parameter()] [string] $ExpandJsonProperty
    )
    process {
        if( $PSCmdlet.ParameterSetName -eq 'StoredConfig' ) {
            $ApiConfig = Get-ApiConfiguration $ApiName -ErrorAction Stop
            $BaseUri = $ApiConfig.BaseUri

            $Query += $ApiConfig.BaseQuery
            $Headers += $ApiConfig.BaseHeaders
            $ExtraRestParameters += $ApiConfig.ExtraRestParameters

            if( $PaginatedEndpoint ) {
                $PaginationAction = [scriptblock]::Create( $ApiConfig.PaginationAction )
                $PaginationStopCondition = [scriptblock]::Create( $ApiConfig.PaginationStopCondition )
            }
        }
        $RestParam = $ExtraRestParameters
        $RestParam['Method'] = $Method
        if( $PSBoundParameters.ContainsKey('Body') ) {
            $RestParam['ContentType'] = 'application/json'
            $RestParam['Body'] = $Body | ConvertTo-Json -EscapeHandling EscapeNonAscii -Compress -AsArray:($Body -is [array])
        }

        $Page = 1
        do {
            if( $PaginatedEndpoint -and $Page -ne 1 ) {
                $PaginationAction.InvokeReturnAsIs()
            }
            $RestParam['Uri'] = New-Uri -BaseUri $BaseUri -Path $Path -Query $Query
            $RestParam['Headers'] = $Headers
            $ShouldProcess = $PSCmdlet.ShouldProcess( "$( [PSCustomObject] $RestParam )", 'Invoke-RestMethod' )
            if( $ShouldProcess ) {
                $Content = Invoke-RestMethod @RestParam | Write-Output
                $OutputContent = $Content
                if( $PSBoundParameters.ContainsKey('ExpandJsonProperty') ) {
                    $OutputContent = $OutputContent | Select-Object -ExpandProperty $ExpandJsonProperty
                }
                Write-Output $OutputContent
            }
            if( $PaginatedEndpoint ) {
                $Page++
            }
        } until( $ShouldProcess -eq $false -or $PaginatedEndpoint -ne $true -or $Page -gt $MaximumPages -or $PaginationStopCondition.InvokeReturnAsIs() ?? $true )
    }
}