
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
    if( $null -eq $Script:ApiConfig ) {
        $Script:ApiConfig = [System.Collections.Generic.Dictionary[string,hashtable]]::new()
    }
    $Script:ApiConfig[$ApiName] = @{
        BaseUri                 = $BaseUri
        BaseHeaders             = $BaseHeaders
        BaseQuery               = $BaseQuery
        PaginationAction        = $PaginationAction
        PaginationStopCondition = $PaginationStopCondition
        ExtraRestParameters     = $ExtraRestParameters
    }
}