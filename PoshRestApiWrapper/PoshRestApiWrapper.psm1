
'Modules', 'Public', 'Private' | Join-Path $PSScriptRoot -ChildPath { $_ } -PipelineVariable Path |
Where-Object { Test-Path $_ -PathType Container } | ForEach-Object {
    switch( Split-Path -LeafBase $Path ) {
        { 'Modules' -eq $_ } {
            Get-ChildItem $Path -Directory -PipelineVariable ModulePath | ForEach-Object {
                $Module = $ModulePath.BaseName
                $ModuleFile = @('psd1', 'psm1').ForEach{ "${Module}.${_}" } | Join-Path $ModulePath -ChildPath { $_ } |
                    Where-Object { Test-Path $_ -PathType Leaf } | Select-Object -First 1
                try {
                    Import-Module $ModuleFile 
                } catch {
                    Write-Warning ( '{0}: {1}' -f $Module, $_.Exception.Message )
                    continue
                }
                Get-Command -Module $Module | Write-Output -InputObject { $_.Name }
            }
        }
        { 'Public', 'Private' -contains $_ } {
            Get-ChildItem $Path -File -Recurse -Filter '*.ps1' -PipelineVariable FunctionFile | ForEach-Object {
                try {
                    . $FunctionFile
                } catch {
                    Write-Warning ( '{0}: {1}' -f $FunctionFile.Name, $_.Exception.Message )
                    continue
                }
            }
        }
        { 'Public' -eq $_ } {
            Get-Command -Module (Split-Path -LeafBase $PSCommandPath) | Write-Output -InputObject { $_.Name }
        }
    }
} | Export-ModuleMember -Function { $_ }
