
#region Dependencies
# Load Web assembly when needed
# PowerShell Core has the assembly preloaded
if( -not ( 'System.Web.HttpUtility' -as [Type] ) ) {
    ls
    
}
# Load System.Net.Http when needed
# PowerShell Core has the assembly preloaded
if( -not ( 'System.Net.Http.HttpRequestException' -as [Type] ) ) {
    Add-Type -AssemblyName 'System.Net.Http'
}
if( -not ( 'System.Net.Http' -as [Type] ) ) {
    Add-Type -Assembly 'System.Net.Http'
}
#endregion Dependencies

#region LoadFunctions
$FunctionFiles = [System.IO.FileInfo[]] @(
    [IO.Path]::Combine( $PSScriptRoot, 'Private', 'Get-ApiConfiguration.ps1' )
    [IO.Path]::Combine( $PSScriptRoot, 'Private', 'New-Uri.ps1' )
    [IO.Path]::Combine( $PSScriptRoot, 'Public',  'Invoke-ApiMethod.ps1' )
    [IO.Path]::Combine( $PSScriptRoot, 'Public',  'Set-ApiConfiguration.ps1' )
)
# Dot-source the functions
foreach( $File in $FunctionFiles ) {
    try {
        . $File.FullName
    }
    catch {
        $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
            [System.ArgumentException] 'Function not found',
            'LoadFunctions',
            [System.Management.Automation.ErrorCategory]::ObjectNotFound,
            $File
        )
        $ErrorRecord.ErrorDetails = 'Failed to import function {0}' -f $File.BaseName
        throw $ErrorRecord
    }
}
#endregion LoadFunctions

#region ModuleScopeVariables
$Script:ApiConfig = [System.Collections.Generic.Dictionary[string,hashtable]]::new()
#endregion ModuleScopeVariables

#region ExportModuleMembers
Export-ModuleMember -Function @(
    'Invoke-ApiMethod'
    'Set-ApiConfiguration'
)
#endregion ExportModuleMembers