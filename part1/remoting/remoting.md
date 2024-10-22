# PowerShell Remoting

PowerShell remoting is a powerful feature that allows you to execute commands and scripts on remote computers. It's a fundamental tool for managing and automating tasks across multiple systems in a network environment.


## Key Concepts of PowerShell Remoting

1. **Enable Remoting**: Before using remoting, it must be enabled on the target computer using `Enable-PSRemoting`.

2. **One-to-One Remoting**: Interact with a single remote computer in an interactive session.

3. **One-to-Many Remoting**: Execute commands on multiple remote computers simultaneously.

4. **PowerShell Sessions**: Create persistent connections to remote computers for improved performance when running multiple commands.

5. **Security**: Remoting uses Windows Remote Management (WinRM) and is secured by default.

## Enabling PowerShell Remoting

To enable PowerShell remoting on a computer, run the following command with administrator privileges:

```powershell
Enable-PSRemoting -Force
```

This command configures the computer to receive remote commands and sets up the necessary firewall rules.

## One-to-One Remoting

To start an interactive session with a remote computer:

```powershell
Enter-PSSession -ComputerName RemoteComputer
```

## One-to-Many Remoting

To run a command on multiple remote computers:

```powershell
Invoke-Command -ComputerName Computer1, Computer2 -ScriptBlock { Get-Process }
```

## PowerShell Sessions

Create a persistent session:

```powershell
$session = New-PSSession -ComputerName RemoteComputer
```

Use the session for multiple commands:

```powershell
Invoke-Command -Session $session -ScriptBlock { Get-Service }
```

PowerShell remoting is a essential feature for efficient system administration and automation across networks. Understanding its capabilities and limitations is crucial for effective use in complex environments.

# Exercise

I have created a mahcine runningon azure
try to remote into it using PowerShell remoting.
and figure out the information about the systemt this machine is running on.



# Introduction to REST APIs

Understanding REST APIs and JSON is crucial.

Most web services communicate via REST API queries, and this is the primary method for exposing your applications publicly.

### What is a REST API?

REST (Representational State Transfer) API is a standardized approach for building web services. It allows different software systems to communicate over the internet, enabling applications to exchange data and functionality.

Key points:
- Uses standard HTTP methods (GET, POST, PUT, DELETE)
- Stateless: each request contains all necessary information
- Typically returns data in JSON format

### PowerShell and REST APIs

PowerShell is an excellent tool for interacting with REST APIs. 
It provides the `Invoke-RestMethod` cmdlet, which makes it easy to send HTTP/HTTPS requests to RESTful web services and work with the response data.

`Invoke-RestMethod` allows you to:
- Send requests to REST APIs
- Handle authentication and headers
- Automatically parse the response (e.g., from JSON to PowerShell objects)


Basic syntax:
```powershell
Invoke-RestMethod -Uri "https://api.example.com/data" -Method Get
```

### Common HTTP Methods

1. **GET**: Retrieves data from the specified resource.
   - Used for reading or fetching data
   - Does not modify the resource
   - Example: Fetching user information

2. **POST**: Submits data to be processed by the specified resource.
   - Used for creating new resources
   - Can modify server state
   - Example: Creating a new user account

### JSON: The Language of REST

JSON (JavaScript Object Notation) is the most common data format for REST APIs because it's:
- Lightweight and efficient
- Easy for both humans and machines to read/write
- Language-independent

Understanding REST APIs and JSON is crucial in today's interconnected digital world, especially for developers and IT professionals working with diverse systems and services.

Now, let's see how PowerShell can interact with REST APIs...

### Example 1: GET Request to a Public API

Let's fetch a random joke from the JokeAPI:

```powershell
$response = Invoke-RestMethod -Uri "https://v2.jokeapi.dev/joke/Programming?type=single" -Method Get
Write-Output "Here's a programming joke for you:"
Write-Output $response.joke
```

### Example 2: POST Request to a Public API

For this example, we'll use the JSONPlaceholder API, which allows POST requests for testing:

```powershell
$body = @{
    title = 'foo'
    body = 'bar'
    userId = 1
} | ConvertTo-Json

$response = Invoke-RestMethod -Uri "https://jsonplaceholder.typicode.com/posts" -Method Post -Body $body -ContentType "application/json"

Write-Output "Created post:"
Write-Output "ID: $($response.id)"
Write-Output "Title: $($response.title)"
Write-Output "Body: $($response.body)"
```

