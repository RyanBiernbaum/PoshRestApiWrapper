
Describe 'Invoke-ApiMethod' {
    BeforeAll {
        [IO.Path]::Combine( $PSCommandPath, '..', '..', 'PoshRestApiWrapper.psd1' ) | Import-Module -Force
    }
    InModuleScope PoshRestApiWrapper {
        It "" -TestCases @(
            
        ) -Test {
            
        }
    }
}
