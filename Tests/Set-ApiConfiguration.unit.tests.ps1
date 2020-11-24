
Describe 'Set-ApiConfiguration' {
    BeforeAll {
        Join-Path $PSCommandPath '..' 'TestHelper.psm1' | Import-Module -Force -ErrorAction Stop
        Reset-Environment
    }
    AfterEach {
        Reset-Environment -SetModuleScopeVariables @{
            ApiConfig = [System.Collections.Generic.Dictionary[string,hashtable]]::new()
        }
    }
    It "Given valid parameters, it sets the appropriate module-scoped variables" -TestCases @(
        @{
            ApiName     = 'TestApi'
            BaseUri     = 'http://somesite.com/api/v1'
            BaseHeaders = @{ 'X-API-Key' = 'abcdef12345' }
            Expected    = @{
                BaseUri                 = [uri] 'http://somesite.com/api/v1'
                BaseHeaders             = @{ 'X-API-Key' = 'abcdef12345' }
                BaseQuery               = @{ }
                PaginationAction        = [scriptblock] { }
                PaginationStopCondition = [scriptblock] { }
                ExtraRestParameters     = @{ }
            }
        },
        @{
            ApiName                 = 'PaginatedApi'
            BaseUri                 = 'https://somepagedapi.com'
            BaseQuery               = @{ apikey = 'abcdef12345' }
            PaginationAction        = [scriptblock] { $Query['page'] = $Page }
            PaginationStopCondition = [scriptblock] { $Page -gt $Content.links.last }
            ExtraRestParameters     = @{ SkipCertificateCheck = $true }
            Expected                = @{
                BaseUri                 = [uri] 'https://somepagedapi.com'
                BaseHeaders             = @{ }
                BaseQuery               = @{ apikey = 'abcdef12345' }
                PaginationAction        = [scriptblock] { $Query['page'] = $Page }
                PaginationStopCondition = [scriptblock] { $Page -gt $Content.links.last }
                ExtraRestParameters     = @{ SkipCertificateCheck = $true }
            }
        }
    ) -Test {
        
        $Keys = @(
            'BaseUri', 'BaseHeaders', 'BaseQuery', 'PaginationAction',
            'PaginationStopCondition','ExtraRestParameters'
        )
        $Param = @{ }
        $Keys.Where{ Test-Path "variable:$_" }.ForEach{ $Param[$_] = Get-Variable $_ -ValueOnly }
        Set-ApiConfiguration -ApiName $ApiName @Param
        $ApiConfig = InModuleScope 'PoshRestApiWrapper' { Get-Variable ApiConfig -Scope Script -ValueOnly }
        $ApiConfig | Should -Not -BeNullOrEmpty -ErrorAction Stop
        $Keys.ForEach{
            ($ApiConfig[$ApiName].$_ | Format-List | Out-String ) | Should -BeExactly ($Expected[$_] | Format-List | Out-String)
        }
    }
}
