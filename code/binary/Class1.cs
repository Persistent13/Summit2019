using System;
using System.Management.Automation;
using Microsoft.ApplicationInsights;
using Microsoft.ApplicationInsights.Extensibility;

namespace binary
{
    public class Module
    {
        static TelemetryClient tc = new TelemetryClient(new TelemetryConfiguration("f5b46359-41c3-4f4f-9c51-639304b82e33"));

        public class Cmdlets
        {
            [Cmdlet(VerbsLifecycle.Invoke, "Example")]
            public class InvokeExample : PSCmdlet
            {
                protected override void BeginProcessing()
                {
                    WriteVerbose("telemetry ran");
                    tc.TrackPageView(MyInvocation.MyCommand.ToString());
                }
                protected override void ProcessRecord()
                {
                    WriteObject("example invoked");
                }
                protected override void EndProcessing()
                {
                    tc.Flush();
                }
            }
        }
    }
}
