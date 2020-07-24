
Describe 'New-Uri' {
    BeforeAll {
        [IO.Path]::Combine( $PSCommandPath, '..', '..', 'PoshRestApiWrapper.psd1' ) | Import-Module -Force
    }
    InModuleScope PoshRestApiWrapper {
        Context 'From BaseUri and Path' {
            It "Given -BaseUri '<BaseUri>' and -Path '<Path>', it returns <Expected>" -TestCases @(
                @{ BaseUri = 'http://sitewithoutpath.com/'     ; Path = '/test/path'; Expected = [uri] 'http://sitewithoutpath.com/test/path' }
                @{ BaseUri = 'https://sitewithoutpath.com/'    ; Path = 'test/path' ; Expected = [uri] 'https://sitewithoutpath.com/test/path' }
                @{ BaseUri = 'http://sitewithoutpath.com'      ; Path = '/test/path'; Expected = [uri] 'http://sitewithoutpath.com/test/path' }
                @{ BaseUri = 'https://sitewithoutpath.com'     ; Path = 'test/path' ; Expected = [uri] 'https://sitewithoutpath.com/test/path' }
                @{ BaseUri = 'http://sitewithoutpath.com:8080' ; Path = 'test/path' ; Expected = [uri] 'http://sitewithoutpath.com:8080/test/path' }
                @{ BaseUri = 'http://sitewithpath.com/api/'    ; Path = '/test/path'; Expected = [uri] 'http://sitewithpath.com/api/test/path' }
                @{ BaseUri = 'https://sitewithpath.com/api/'   ; Path = 'test/path' ; Expected = [uri] 'https://sitewithpath.com/api/test/path' }
                @{ BaseUri = 'http://sitewithpath.com/api'     ; Path = '/test/path'; Expected = [uri] 'http://sitewithpath.com/api/test/path' }
                @{ BaseUri = 'https://sitewithpath.com/api'    ; Path = 'test/path' ; Expected = [uri] 'https://sitewithpath.com/api/test/path' }
                @{ BaseUri = 'http://sitewithpath.com:8443/api'; Path = 'test/path' ; Expected = [uri] 'http://sitewithpath.com:8443/api/test/path' }
            ) -Test {
                New-Uri -BaseUri $BaseUri -Path $Path | Should -BeExactly $Expected
            }
        }
        Context 'From BaseUri, Path, and Query' {
            $Queries = @(
                @{ 'key1'                     = 'value1'; 'key2' = 'value2' }
                @{ "key/with%special{chars}'" = 'value1'; 'key2' = 'value2' }
                @{ 'key1'                     = 'value1'; 'key2' = 'Value|With\Special^Chars' }
                @{ 'key with;special<"chars[' = '>Value@With?Special:Chars=' }
            )
            It "Given -BaseUri '<BaseUri>', -Path '<Path>', and -Query it returns a Uri matching '<Expected>'" -TestCases $Queries.ForEach{
                @{ BaseUri = 'https://site.com/api/'; Path = '/path'; Query = $_ } + @{
                    Expected = [ordered] @{
                        UriWithoutQuery = 'https://site.com/api/path'
                        KeyValuePairs   = $_.GetEnumerator().ForEach{ @{ $_.Key = $_.Value } } | Sort-Object
                    } | ConvertTo-Json -Compress
                }
            } -Test {
                $ActualUri = New-Uri -BaseUri $BaseUri -Path $Path -Query $Query
                $ActualQuery = [System.Web.HttpUtility]::ParseQueryString( $ActualUri.Query )
                [ordered] @{
                    UriWithoutQuery = $ActualUri.AbsoluteUri.Replace( $ActualUri.Query, '' )
                    KeyValuePairs   = $ActualQuery.GetEnumerator().ForEach{ @{ $_ = $ActualQuery.Item($_) } } | Sort-Object
                } | ConvertTo-Json -Compress | Should -BeExactly $Expected
            }
        }
    }
}
