
function New-Uri {
    [CmdletBinding(PositionalBinding)]
    [OutputType([uri])]
    param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName)] [uri] $BaseUri,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName)] [string] $Path,
        [Parameter(ValueFromPipelineByPropertyName)] [hashtable] $Query = @{ }
    )
    process {
        $QueryCollection = [System.Web.HttpUtility]::ParseQueryString( [string]::Empty )
        $Query.GetEnumerator().ForEach{ $QueryCollection.Add( $_.Key, $_.Value ) }
        $UriBuilder = [System.UriBuilder] @{
            Scheme = $BaseUri.Scheme
            Host   = $BaseUri.Host
            Port   = $BaseUri.Port
            Path   = '{0}/{1}' -f $BaseUri.AbsolutePath.TrimEnd('/'), $Path.TrimStart('/')
            Query  = $QueryCollection.ToString()
        }
        Write-Output $UriBuilder.Uri
    }
}