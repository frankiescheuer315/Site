# Script para fazer upload do site para o GitHub
# Execute este script após instalar o Git

Write-Host "=== Upload para GitHub ===" -ForegroundColor Green
Write-Host ""

# Verificar se o Git está instalado
try {
    $gitVersion = git --version
    Write-Host "Git encontrado: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "ERRO: Git não está instalado ou não está no PATH" -ForegroundColor Red
    Write-Host "Por favor, instale o Git de: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Ou use uma das outras opções descritas no README.md" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Inicializando repositório Git..." -ForegroundColor Cyan

# Verificar se já é um repositório Git
if (Test-Path .git) {
    Write-Host "Repositório Git já existe." -ForegroundColor Yellow
} else {
    git init
    Write-Host "Repositório Git inicializado." -ForegroundColor Green
}

Write-Host ""
Write-Host "Adicionando arquivos..." -ForegroundColor Cyan
git add .

Write-Host ""
Write-Host "Fazendo commit..." -ForegroundColor Cyan
git commit -m "Initial commit - Site Licencia Soluções Ambientais"

Write-Host ""
Write-Host "Configurando branch main..." -ForegroundColor Cyan
git branch -M main

Write-Host ""
Write-Host "Adicionando remote origin..." -ForegroundColor Cyan
# Verificar se o remote já existe
$remoteExists = git remote | Select-String -Pattern "origin"
if ($remoteExists) {
    Write-Host "Remote 'origin' já existe. Atualizando..." -ForegroundColor Yellow
    git remote set-url origin https://github.com/frankiescheuer315/Site.git
} else {
    git remote add origin https://github.com/frankiescheuer315/Site.git
}

Write-Host ""
Write-Host "Fazendo push para o GitHub..." -ForegroundColor Cyan
Write-Host "NOTA: Você pode precisar fazer login no GitHub" -ForegroundColor Yellow
Write-Host ""

try {
    git push -u origin main
    Write-Host ""
    Write-Host "=== SUCESSO! ===" -ForegroundColor Green
    Write-Host "Seu site foi enviado para: https://github.com/frankiescheuer315/Site" -ForegroundColor Green
} catch {
    Write-Host ""
    Write-Host "ERRO ao fazer push. Verifique:" -ForegroundColor Red
    Write-Host "1. Se você está autenticado no GitHub" -ForegroundColor Yellow
    Write-Host "2. Se tem permissão para fazer push no repositório" -ForegroundColor Yellow
    Write-Host "3. Se o repositório existe no GitHub" -ForegroundColor Yellow
}

