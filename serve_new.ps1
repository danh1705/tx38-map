param(
  [int]$Port = 8000
)

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()

Write-Host "Serving on http://localhost:$Port/  (Ctrl+C or close window to stop)"

while ($listener.IsListening) {
  try {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    $path = $request.Url.AbsolutePath.TrimStart('/')
    if ([string]::IsNullOrWhiteSpace($path)) { $path = "index_precincts_targeting.html" }

    $localPath = Join-Path (Get-Location) $path

    if (!(Test-Path $localPath)) {
      $response.StatusCode = 404
      $bytes = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $path")
      $response.OutputStream.Write($bytes, 0, $bytes.Length)
      $response.OutputStream.Close()
      continue
    }

    $ext = [System.IO.Path]::GetExtension($localPath).ToLowerInvariant()
    switch ($ext) {
      ".html" { $response.ContentType = "text/html; charset=utf-8" }
      ".js"   { $response.ContentType = "application/javascript; charset=utf-8" }
      ".css"  { $response.ContentType = "text/css; charset=utf-8" }
      ".json" { $response.ContentType = "application/json; charset=utf-8" }
      ".geojson" { $response.ContentType = "application/geo+json; charset=utf-8" }
      default { $response.ContentType = "application/octet-stream" }
    }

    $bytes = [System.IO.File]::ReadAllBytes($localPath)
    $response.ContentLength64 = $bytes.Length
    $response.OutputStream.Write($bytes, 0, $bytes.Length)
    $response.OutputStream.Close()
  }
  catch {
    break
  }
}

try { $listener.Stop() } catch { }
