function Set-TelemetryOption {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([String])]
    Param (
        # Telemetry levels
        [Parameter(Mandatory)]
        [ValidateSet('None', 'Full')]
        [string]
        $TelemetryLevel
    )
    
    begin {
    }
    
    process {
        @{TelemetryLevel=$TelemetryLevel} | ConvertTo-Json -Compress | Out-File -FilePath $env:ProgramData\Telemetry\config.json
        $script:TelemetrySetting = $TelemetryLevel
    }
    
    end {
    }
}

function Get-TelemetryOption {
        [CmdletBinding()]
        [OutputType([String])]
        Param ()
        
        begin {
        }
        
        process {
            Get-Content -Raw -Path $env:ProgramData\Telemetry\config.json | ConvertFrom-Json | Select-Object -ExpandProperty TelemetryLevel
        }
        
        end {
        }
    }

function Invoke-Example {
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param ()
    
    begin {
        if ($Script:TelemetrySetting -ne 'None') {
            Write-Verbose -Message 'Telemetry ran'
            $script:tc.TrackPageView($pscmdlet.MyInvocation.MyCommand)
        }
    }
    
    process {
        'Example was invoked'
    }
    
    end {
        $script:tc.Flush()
    }
}

$script:TelemetrySetting = Get-TelemetryOption
$script:tc = [Microsoft.ApplicationInsights.TelemetryClient]::new()
$script:tc.InstrumentationKey = 'f5b46359-41c3-4f4f-9c51-639304b82e33'
# Run a script block when a module is unloaded
# Does not run when powershell is closed
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = { $script:tc.Flush(); 'Thank you for using my module!' }
