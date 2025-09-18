# 🧰 PowerShell Basics: Objects & Variables

## 🚀 What Makes PowerShell Special?

Unlike other shells (like Bash or CMD), PowerShell doesn't just return plain text — it returns **objects**. 
Understanding how to use **objects** and **variables** is one of the key topics.

### 🔍 The Fundamental Difference

**Traditional Shell (CMD/Bash):**
```bash
# Returns just text strings
dir
# Output: "file1.txt  file2.doc  folder1"
```

**PowerShell:**
```powershell
# Returns rich objects with properties and methods
Get-ChildItem
# Each item is a full object with Name, Size, CreationTime, etc.
```

Think of it this way: If you ask a traditional shell "What files are in this folder?", it gives you just text - like reading names from a phone book. But 
PowerShell gives you the full dashboard with everything in and related to the files and folders.


### 🎯 Why Objects Matter

**🔸 More Information**: Instead of just getting file names, you get file sizes, creation dates, permissions, and more
```powershell
# Traditional: just "notepad.exe"
# PowerShell: Name, Size, LastWriteTime, IsReadOnly, etc.
Get-ChildItem File1.txt | Select-Object Name, Size, LastWriteTime, IsReadOnly, etc.
```

**🔸 More Control**: You can easily sort, filter, and manipulate data without complex text parsing
```powershell
# Sort files by size (impossible with plain text!)
Get-ChildItem | Sort-Object Length -Descending
```

**🔸 More Power**: You can perform complex operations with simple, readable commands
```powershell
# Find large files older than 30 days
Get-ChildItem | Foreach-Object { $_.Delete()}
```

---

## 🧱 What is an Object?

An **object** in PowerShell is like a data container. It has:

- **Properties** – describe the object (like characteristics of a person)
  - Example: A file object has properties like name, size, and creation date
  - Think of properties as the "what" about an object

- **Methods** – actions the object can perform (like things a person can do)
  - Example: A file object can be copied, deleted, or moved
  - Think of methods as the "how" to interact with an object

### 📝 Real-World Analogy
Imagine a car as an object:
- **Properties**: color, brand, model, year
- **Methods**: start(), stop(), accelerate(), brake()

In PowerShell, everything is an object - files, processes, services, and more. This makes PowerShell much more powerful than traditional shells!

![PowerShell Object Structure](images/object.png)

### 📦 Example: Process Object

```powershell
Get-Process
```

This returns a list of **process objects**. Each one has properties like `Name`, `Id`, `CPU`, and methods like `Kill()`.

View the details:

```powershell
Get-Process | Get-Member
```

---

### 🔎 Viewing Properties

To display specific properties:

```powershell
Get-Process | Select-Object Name, CPU
```

Output example:

```
Name       CPU
----       ---
notepad    2.31
explorer   1.58
```

---



## 💾 What is a Variable?

A **variable** is a named placeholder for storing data. In PowerShell, variable names start with `$`.

### 📌 Creating Variables

```powershell
$name = "PowerShell"
$number = 42
$file = Get-Item "C:\Windows\notepad.exe"
```

### 🧪 Using Variables

```powershell
Write-Output $name
Write-Output $file.Length
```

---

## 🧠 Visual: Object with Properties & Methods

```
+--------------------------+
|   FileInfo Object        |
+--------------------------+
| Name     : notepad.exe   |
| Length   : 17920         |
| Exists   : True          |
+--------------------------+
| Methods:                 |
| - Delete()               |
| - CopyTo()               |
+--------------------------+
```

To explore this:

```powershell
Get-Item "C:\Windows\notepad.exe" | Get-Member
```

---

## 🧠 Visual: Variable Holding an Object

```
$myFile = Get-Item "C:\file.txt"

      ┌──────────────────────────────┐
$myFile ─►  FileInfo Object          │
        │  ─ Name: file.txt          │
        │  ─ Length: 834             │
        │  ─ CreationTime: ...       │
        └────────────────────────────┘
```

---

### ⚙️ Calling Methods

You can use methods to perform actions:

```powershell
$proc = Get-Process -Name notepad
$proc.Kill()
```

This stops the Notepad process using the `Kill()` method.

---


## 🧪 Exercises


## Interactive Exercise: Working with Process Objects

### Task
1. Get the Notepad process and store it in a variable
2. Explore the available methods
3. Try to stop the process using one of the methods

<details>
<summary>Click to see the solution</summary>

```powershell
# 1. Get the process and store it
$notepad = Get-Process notepad

# 2. Explore methods
$notepad | Get-Member -MemberType Method

# 3. Stop the process
$notepad.Kill()  # or $notepad.Stop()
```
</details>

---

## ✅ Summary

- PowerShell returns **objects**, not just text.
- Objects have **properties** and **methods**.
- You can store objects in **variables** and interact with them.
- Use `Get-Member` to explore any object.

---

> 💡 Tip: Almost everything in PowerShell is an object. Try `Get-Date | Get-Member` to see for yourself!
