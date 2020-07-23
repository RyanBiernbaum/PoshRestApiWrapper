
function Set-ApiConfiguration {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(Mandatory=$true,Position=0)] [string] $ApiName,
        [Parameter(Mandatory=$true)] [uri] $BaseUri,
        [Parameter()] [hashtable] $BaseHeaders = @{ },
        [Parameter()] [hashtable] $BaseQuery = @{ },
        [Parameter()] [scriptblock] $PaginationAction = { },
        [Parameter()] [scriptblock] $PaginationStopCondition = { },
        [Parameter()] [hashtable] $ExtraRestParameters = @{ }
    )
    $Script:ApiConfig[$ApiName] = @{
        BaseUri                 = $BaseUri
        BaseHeaders             = $BaseHeaders
        BaseQuery               = $BaseQuery
        PaginationAction        = $PaginationAction
        PaginationStopCondition = $PaginationStopCondition
        ExtraRestParameters     = $ExtraRestParameters
    }
}