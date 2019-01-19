# Instroduction of who I am

- Dakota Clark
- Work for PDQ.com
- On the QA team

# What is application insights?

- Is now included as part of Azure Monitor (done after talk accepted! 😒)
- Application Performance Management (APM), think code level monitoring
- Can Run anywhere, no requirement for it to be hosted in Azure

# How to use effectivly in PowerShell

- How to download and use
- When to use framework / core / standard dll
- Why having the Instrumentation Key unencrypted is okay and you can't do much about it
  - https://neilpatel.com/blog/protect-analytics-from-hacking/
  - https://blogs.msdn.microsoft.com/premier_developer/2017/12/14/alternative-way-to-protect-your-application-insights-instrumentation-key-in-javascript/
  - https://stackoverflow.com/questions/27816528/application-insights-security-and-spoofing
  - https://github.com/Microsoft/ApplicationInsights-JS/issues/281

### Code Examples

- Upload whole exceptions
- Measure code execution time
- Flush on function / cmdlet completion
- Flush on module unload
- How to allow users to control telemetry collection

### Limits of different types of methods

- FIND LIMITS
