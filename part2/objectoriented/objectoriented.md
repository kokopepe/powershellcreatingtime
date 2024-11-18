# Object-Oriented Programming in PowerShell

PowerShell is an object-oriented scripting language. It represents data and system states using structured objects derived from .NET classes. 

In PowerShell, each item is an instance of an object that can be explored and manipulated.

To understand object-oriented concepts in PowerShell, let's consider two examples: a car and a Windows service.

1. Object Definition:
   An object is a self-contained unit representing a real-world entity or system component. Our examples are a "Car" object and a "Service" object.

2. Properties:
   Properties are characteristics or attributes of an object. They describe the object's state.


| Example Car                | Example PowerShell Service        |
| Property | Example Value   | Property  | Example Value         |
| Make     | Tesla          | Name      | wuauserv (Windows Update) |
| Model    | Model S         | Status    | Running, Stopped      |
| Year     | 2024            | StartType | Automatic, Manual     |

3. Methods:
   Methods are actions that an object can perform or that can be performed on the object.

| Example Car                | Example PowerShell Service        |
| Method   | Description     | Method    | Description           |
| Start()  | Turns on the engine | Start() | Starts the service  |
| Stop()   | Turns off the engine | Stop() | Stops the service   |

4. Encapsulation and Implementation:
   While "Car" is an abstract concept, a specific car (like a Tesla Model S) is an actual implementation or instance of that concept. 
   
   Similarly, in PowerShell, when you create an object like `$webclient = New-Object System.Net.WebClient`, `System.Net.WebClient` is the abstract class, but `$webclient` is the actual instance you work with. 
   
   This encapsulation allows you to interact with the object's properties and methods

In PowerShell, you interact with objects by accessing their properties or invoking their methods. For example:

- To get the status of the Windows Update service:
  $service = Get-Service -Name "wuauserv"
  $service.Status

- To stop the Windows Update service:
  $service.Stop()

This object-oriented approach in PowerShell allows you to work with complex, structured data representing  system components in a consistent and intuitive way.

# PowerShell and .NET Framework

PowerShell is built on the .NET Framework, which gives it powerful capabilities. Here's a simplified overview:

1. **.NET Framework components:**
   - Framework Class Library (FCL): A vast collection of reusable code
   - Common Language Runtime (CLR): The engine that runs .NET code

2. **Key concepts:**
   - Namespace: Organizes related classes (e.g., `System.Net`)
   - Class: A blueprint for creating objects (e.g., `System.Net.WebClient`)
   - Object: An instance of a class
   - Properties: Data associated with an object
   - Methods: Actions an object can perform

3. **PowerShell and .NET:**
   - PowerShell can access and use .NET classes directly
   - This extends PowerShell's capabilities beyond built-in cmdlets
   - Most tasks can be accomplished with cmdlets or community modules
   - Understanding .NET concepts helps grasp PowerShell's underlying structure

4. **Practical usage:**
   - You can create .NET objects in PowerShell: 
     ```powershell
     $webclient = New-Object System.Net.WebClient
     ```
   - Objects have properties and methods you can interact with
   - Compare using a .NET object vs. a built-in cmdlet:
     ```powershell
     # Using .NET WebClient object
     $webclient = New-Object System.Net.WebClient
     $content = $webclient.DownloadString("https://google.com")

     # Using built-in Invoke-WebRequest cmdlet
     $response = Invoke-WebRequest -Uri "https://google.com"
     $content = $response.Content
     ```
   - Both approaches achieve the same result, but the built-in cmdlet is often more convenient

5. **Get-Member:**
   - Helps explore an object's properties and methods
   - Useful for understanding what you can do with an object

6. **Example using Get-Process:**
   - `Get-Process` returns objects representing running processes
   - Each object is an instance of the `System.Diagnostics.Process` class
   - You can explore these objects with `Get-Member`:
     ```powershell
     Get-Process | Get-Member
     ```
   - This shows properties like `Name`, `Id`, and methods like `Kill()`
   - You can then use these properties and methods:
     ```powershell
     (Get-Process notepad).Name  # Access a property
     (Get-Process notepad).Kill()  # Invoke a method
     ```

This foundation, along with the practical `Get-Process` example, will help you better understand how to use `Get-Member` and work with objects in PowerShell.
