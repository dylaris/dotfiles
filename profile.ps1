# nook
Invoke-Expression (& { (lua D:\Project\Personal\nook\nook.lua --start powershell) -join "`n" })
$env:NOOKINI = "D:\Project\Personal\nookme\.nookini.lua"

Set-PSReadlineOption -EditMode Emacs
Set-PSReadLineOption -Colors @{
    ListPrediction     = "DarkGray"
    InlinePrediction   = "DarkGray"
}

function prompt {
    $time = Get-Date -Format "HH:mm"
    $user = $env:USERNAME
    $path = $PWD.Path.Replace($HOME, "~")

    $dim   = [ConsoleColor]::DarkGray
    $green = [ConsoleColor]::Green
    $gold  = [ConsoleColor]::DarkYellow
    $cyan  = [ConsoleColor]::Cyan
    $red   = [ConsoleColor]::Red

    Write-Host "[$time] " -NoNewline -ForegroundColor $cyan
    Write-Host "$user" -NoNewline -ForegroundColor $gold
    Write-Host " :: " -NoNewline -ForegroundColor $dim
    Write-Host "$path" -ForegroundColor $green

    Write-Host ">>" -NoNewline -ForegroundColor $red
    return " "
}
