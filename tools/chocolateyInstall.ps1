$ErrorActionPreference = 'Stop'; # parar em todos os erros
$currentVersion = "0.0.1"
# Parâmetros do pacote Chocolatey
$packageArgs = @{
    packageName    = 'REnv'
    softwareName   = 'REnv*'
    fileType       = 'exe'
    silentArgs     = '/qn /norestart'
    validExitCodes = @(0)
    checksumType   = 'sha256'
    url            = 'https://github.com/espinhara/REnv/raw/master/REnv.exe'
    checksum       = '85FC2110CFD2B4008EA7B1B67312BF713B868E3B60249A3E8A7BEF32532DA1F4'
}

# Instala o pacote Chocolatey
Install-ChocolateyPackage @packageArgs

# Move o executável para um diretório acessível aos usuários comuns
$installDirectory = "C:\Users\Public"
$executableName = 'REnv.exe'
$folderName = 'REnv'

# Verifica se o diretório de instalação existe
if (!(Test-Path $installDirectory)) {
    Write-Host "Creating directory $installDirectory"
    New-Item -Path $installDirectory -ItemType Directory | Out-Null
}

# Move o executável para o diretório de instalação
Copy-Item -Path $env:TEMP\$folderName\$currentVersion\$executableName -Destination $installDirectory -Force

# Adiciona o diretório de instalação ao PATH do usuário atual
$env:Path += ";$installDirectory"

Write-Host @"
    ____  _____                     
    |  _ \| ____| _ __ __   __       
    | |_) |  _|  | '_ \\ \ / /       
    |  _ <| |___ | | | |\ V /   
    |_| \_\_____||_| |_| \_/

"@ -ForegroundColor Blue

# Informa o usuário sobre o sucesso
Write-Host "Executable '$executableName' moved to directory '$installDirectory' and added with success to the PATH."
