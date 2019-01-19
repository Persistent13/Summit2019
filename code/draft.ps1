Add-Type -Path .\Microsoft.ApplicationInsights.dll

$tc = [Microsoft.ApplicationInsights.TelemetryClient]::new()
# How do I get this Instrumentation Key?
$tc.InstrumentationKey = 'f5b46359-41c3-4f4f-9c51-639304b82e33'

# https://docs.microsoft.com/en-us/azure/application-insights/application-insights-data-model-event-telemetry
# Events are lmited to 512 chars
$tc.TrackEvent('Hello World!')

# Can also include properties and metrics in IDictionary
# Custom properties are limited to:
# Max key length: 150 Max value length: 8192
$props = [System.Collections.Generic.Dictionary[string,string]]::new().Add('prop1','value1')
# Custom metrics are limited to:
# Max key length: 150 Max value [double]::MaxValue Min value [double]::MinValue
$metrics = [System.Collections.Generic.Dictionary[string,double]]::new().Add('metric', 1000)
$tc.TrackEvent('Hello Metrics and properties!', $props, $metrics)

# https://docs.microsoft.com/en-us/azure/application-insights/application-insights-data-model-trace-telemetry
# Traces are limited to 32768 chars
$tc.TrackTrace('Ut quia necessitatibus sunt minus ipsa fuga perferendis non. Aut autem nam et sunt numquam laborum possimus. Rerum exercitationem sequi ab similique et. Repellat et repellat aut mollitia corrupti. Unde alias qui similique vero sed dolores. Tenetur quidem quaerat odit sed qui ad.')

# Exceptions can also be tracked
# https://docs.microsoft.com/en-us/azure/application-insights/application-insights-data-model-exception-telemetry

try {
    0/0
} catch {
    $err = [Microsoft.ApplicationInsights.DataContracts.ExceptionTelemetry]::new($_.Exception)
    # Don't have to set time
    #$err.Timestamp = [System.DateTimeOffset]::UtcNow
    $err.ProblemId = $_.FullyQualifiedErrorId
    $err.Message = $_.ScriptStackTrace
    $err.SeverityLevel = [Microsoft.ApplicationInsights.DataContracts.SeverityLevel]::Error

    $tc.TrackException($err)
    $tc.Flush()
}
