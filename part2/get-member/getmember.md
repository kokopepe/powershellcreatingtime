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
