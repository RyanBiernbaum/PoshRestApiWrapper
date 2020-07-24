
Describe 'Invoke-ApiMethod' {
    BeforeAll {
        [IO.Path]::Combine( $PSCommandPath, '..', '..', 'PoshRestApiWrapper.psd1' ) | Import-Module -Force
    }
    InModuleScope PoshRestApiWrapper {
        It "Fill in later" -TestCases @(
            
        ) -Test {
            
        }
    }
}
