# Check OS version
$osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
if ($osInfo.Version -notlike "10.*") {
    Write-Host "This script can only be run on Windows 10."
    return
}

# Sign Up function
function SignUp {
    $username = Read-Host "Enter a username"
    $password = Read-Host "Enter a password"
    $credential = "$username,$password"
    Add-Content -Path .\psnp.txt -Value $credential
    Write-Host "Account created successfully!"
}

# Login function
function Login {
    $username = Read-Host "Enter your username"
    $password = Read-Host "Enter your password"
    $credential = "$username,$password"
    $accounts = Get-Content -Path .\psnp.txt
    if ($accounts -contains $credential) {
        Write-Host "Login successful!"
        # Fetch news headlines using NewsAPI
        $apiKey = "5767563cd0314ff387fe42c845802b9d"  # replace with your actual API key
        $response = Invoke-RestMethod -Uri "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=$apiKey"
        $response.articles | ForEach-Object { $_.title }
    } else {
        Write-Host "Invalid username or password!"
    }
}

# Main function
function Main {
    do {
        $choice = Read-Host "Enter 1 to Sign Up, 2 to Login, 3 to Exit"
        if ($choice -eq 1) {
            SignUp
        } elseif ($choice -eq 2) {
            Login
        } elseif ($choice -eq 3) {
            break
        } else {
            Write-Host "Invalid choice!"
        }
    } while ($true)
}

# Call the main function
Main
