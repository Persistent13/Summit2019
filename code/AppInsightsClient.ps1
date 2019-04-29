Add-Type -Path .\Microsoft.ApplicationInsights.dll

# Instantiate the telemetry client class
$tc = [Microsoft.ApplicationInsights.TelemetryClient]::new()

# Set the instrumentation key as found in Azure Monitor
$tc.InstrumentationKey = 'f5b46359-41c3-4f4f-9c51-639304b82e33'

# Track events!
# https://docs.microsoft.com/en-us/azure/application-insights/application-insights-data-model-event-telemetry
# Events are limited to 512 chars
$tc.TrackEvent('Hello World!')
$tc.Flush()
