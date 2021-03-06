#
# Module manifest for module 'PoshRestApiWrapper'
#
# Generated by: Ryan Biernbaum
#
# Generated on: 11/24/2020
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PoshRestApiWrapper.psm1'

# Version number of this module.
ModuleVersion = '0.0.4'

# Supported PSEditions
CompatiblePSEditions = 'Core'

# ID used to uniquely identify this module
GUID = 'dee653fd-bf12-4be6-b617-18c4aad14b3f'

# Author of this module
Author = 'Ryan Biernbaum'

# Company or vendor of this module
CompanyName = 'Ryan Biernbaum'

# Copyright statement for this module
Copyright = '(c) Ryan Biernbaum. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Provides functions to simplify interaction with REST APIs'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '7.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Invoke-ApiMethod'
    'Set-ApiConfiguration'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = @(
    '.gitignore'
    'LICENSE'
    'PoshRestApiWrapper.psd1'
    'PoshRestApiWrapper.psm1'
    'README.md'
    'Private\Get-ApiConfiguration.ps1'
    'Private\New-Uri.ps1'
    'Public\Invoke-ApiMethod.ps1'
    'Public\Set-ApiConfiguration.ps1'
    'Tests\Get-ApiConfiguration.unit.tests.ps1'
    'Tests\Invoke-ApiMethod.unit.tests.ps1'
    'Tests\New-Uri.unit.tests.ps1'
    'Tests\Set-ApiConfiguration.unit.tests.ps1'
)

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        # ProjectUri = ''

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
