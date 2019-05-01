# Track metric
$tc.TrackMetric('metric name', [double]::MaxValue)
$tc.Flush()

# [Microsoft.ApplicationInsights.DataContracts.MetricTelemetry]::new()
# Microsoft.ApplicationInsights.DataContracts.MetricTelemetry new()
# Microsoft.ApplicationInsights.DataContracts.MetricTelemetry new(string metricName, double metricValue)
# Microsoft.ApplicationInsights.DataContracts.MetricTelemetry new(string name, int count, double sum, double min, double max, double standardDeviation)
# Microsoft.ApplicationInsights.DataContracts.MetricTelemetry new(string metricNamespace, string name, int count, double sum, double min, double max, double standardDeviation)

# Track an execution of something
$tc.TrackPageView('name of item ran')
$tc.Flush()

function Invoke-MetricExample {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [psobject[]]
        $InputObject
    )
    
    begin {
        $tc.TrackPageView($MyInvocation.MyCommand)
    }
    
    process {
        $number_of_objects_processed = 0
        $InputObject | ForEach-Object {
            Write-Output $InputObject
            $number_of_objects_processed++
        }
        $tc.TrackMetric("number of objects processed: $($MyInvocation.MyCommand)", $number_of_objects_processed)
    }
    
    end {
        $tc.Flush()
    }
}
