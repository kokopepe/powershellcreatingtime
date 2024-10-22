# Understanding Get-Member in PowerShell

Get-Member is a powerful cmdlet in PowerShell that provides insight into the objects, properties, and methods associated with PowerShell commands.
 It's an essential tool for exploring and understanding the structure of objects in PowerShell.

## How to Use Get-Member

You can pipe any PowerShell command that produces object-based output to Get-Member. The basic syntax is:

```powershell
Some-Command | Get-Member
```

When you do this, Get-Member reveals the structure of the object returned by the command, detailing its properties and methods.

## Key Concepts

1. **Properties**: These are the attributes of an object. They describe the object's characteristics.

2. **Methods**: These are the actions you can perform on an object.


## Real-World Analogy: The iPhone

- An iPhone is like an object in PowerShell.
- Properties are like the iPhone's specs (e.g., model, storage, battery level).
- Methods are like actions you can do with the iPhone (e.g., make a call, take a photo).
- Get-Member is like opening the iPhone's Settings app to see all its features.
- Using properties/methods in PowerShell is like checking your battery or taking a picture.

## Practical Example

Let's use a practical example with the Windows Time service:

```powershell
Get-Service "W32Time" | Get-Member -MemberType Property
Get-Service "W32Time" | Get-Member -MemberType Method
Get-Service "W32Time" | Get-Member
```

This command will show all the properties and methods of the Windows Time service object. Students can see:

- Properties like Name, Status, DisplayName
- Methods like Start(), Stop(), Pause()

## Why Get-Member is Useful

1. **Exploration**: It helps you discover what you can do with an object.
2. **Debugging**: It can help you understand why a command isn't working as expected.
3. **Scripting**: It aids in writing more efficient and effective scripts by revealing available properties and methods.

## Exercise for Students

Have students try Get-Member with different cmdlets, such as:

```powershell
Get-Process | Get-Member
Get-Date | Get-Member
Get-ChildItem | Get-Member
```

This explanation covers the basics of Get-Member, provides a relatable analogy, includes a practical example, and suggests an exercise for students. It should give your students a solid understanding of what Get-Member is and how it can be used in PowerShell.


#  Remoting and Objects: Local vs Remote Execution

When working with PowerShell remoting, it's important to understand the difference between objects returned by local cmdlets and those returned when using `Invoke-Command` for remote execution:

1. **Local Cmdlet Execution:**
   - Returns live objects
   - Full access to methods and properties
   - Objects can be manipulated directly

2. **Remote Execution with Invoke-Command:**
   - Returns deserialized objects
   - Limited access to properties; most methods are not available
   - Objects are snapshots of the remote state at the time of execution

### Example:

```powershell
# Local execution
$localService = Get-Service -Name W32time
$localService.GetType().FullName
# Output: System.ServiceProcess.ServiceController

# Remote execution
$remoteService = Invoke-Command -ComputerName server01 { Get-Service -Name W32time }
$remoteService.GetType().FullName
# Output: Deserialized.System.ServiceProcess.ServiceController
```

In the remote execution scenario, you can't directly call methods on the returned object. For instance, `$remoteService.Stop()` would fail. Instead, you need to perform actions within the remote session:

```powershell
Invoke-Command -ComputerName server01 { (Get-Service -Name W32time).Stop() }
```

Understanding this difference is crucial when working with remote systems, as it affects how you interact with the returned data and structure your remote commands.



