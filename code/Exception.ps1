# Exceptions can also be tracked!
# https://docs.microsoft.com/en-us/azure/application-insights/application-insights-data-model-exception-telemetry

# [Microsoft.ApplicationInsights.DataContracts.ExceptionTelemetry]::new()
# Microsoft.ApplicationInsights.DataContracts.ExceptionTelemetry new()
# Microsoft.ApplicationInsights.DataContracts.ExceptionTelemetry new(System.Exception exception)
# Microsoft.ApplicationInsights.DataContracts.ExceptionTelemetry new(System.Collections.Generic.IEnumerable[Microsoft.ApplicationInsights.DataContracts.ExceptionDetailsInfo] exceptionDetailsInfoList,
# System.Nullable[Microsoft.ApplicationInsights.DataContracts.SeverityLevel] severityLevel, string problemId, System.Collections.Generic.IDictionary[string,string] properties, System.Collections.Generic.IDictionary[string,double] measurements)

# Tracking an exception
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

# Tracking an exception with addtional information
try {
    10..0 | ForEach-Object { 0 / $_ | Out-Null; $i++ }
} catch {
    $prop = [System.Collections.Generic.Dictionary[[string],[string]]]::new()
    $prop['CommandName'] = $MyInvocation.MyCommand.Name
    $prop['PSVersion'] = $PSVersionTable.PSVersion

    $counts = [System.Collections.Generic.Dictionary[[string],[double]]]::new()
    $counts['Loops'] = $i

    $tc.TrackException($_.Exception, $prop, $counts)
    $tc.Flush()
}
