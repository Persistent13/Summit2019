using System;
using System.Management.Automation;

namespace Summit2019
{
    public class Class1
    {
        public class Telemetry
        {
            //
        }

        public class Cmdlets
        {
            [Cmdlet(VerbsCommon.Invoke, "TelemetryExample")]
            public class InvokeTelemetryExample : Cmdlet
            {
                //
            }
        }
    }
}
