Add-Type -Path .\Microsoft.ApplicationInsights.dll

# Track event
$tc.TrackEvent('Hello World!')
