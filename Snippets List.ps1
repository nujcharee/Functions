﻿## A list of snippets
$snips = Get-IseSnippet
# Create a new snippet snippet!

if(!$snips.Where{$_.Name -like 'New-Snippet*'})
{
$snippet1 = @{
 Title = 'New-Snippet'
 Description = 'Create a New Snippet'
 Text = @"
`$snippet = @{
 Title = `'Put Title Here`'
 Description = `'Description Here`'
 Text = @`"
 Code in Here 
`"@
}
New-IseSnippet @snippet
"@
}
New-IseSnippet @snippet1 –Force
}
# SMO Snippet
if(!$snips.Where{$_.Name -like 'SMO-Server*'})
{
$snippet = @{
 Title = 'SMO-Server'
 Description = 'Creates a SQL Server SMO Object'
 Text = @"
 `$srv = New-Object Microsoft.SqlServer.Management.Smo.Server `$Server
"@
}
New-IseSnippet @snippet
}
## Data table snippet
if(!$snips.Where{$_.Name -like 'New-DataTable*'})
{
$snippet = @{
 Title = 'New-DataTable'
 Description = 'Creates a Data Table Object'
 Text = @"
 # Create Table Object
 `$table = New-Object system.Data.DataTable `$TableName
  
 # Create Columns
 `$col1 = New-Object system.Data.DataColumn NAME1,([string])
 `$col2 = New-Object system.Data.DataColumn NAME2,([decimal])
  
 #Add the Columns to the table
 `$table.columns.add(`$col1)
 `$table.columns.add(`$col2)
  
 # Create a new Row
 `$row = `$table.NewRow() 
  
 # Add values to new row
 `$row.Name1 = 'VALUE'
 `$row.NAME2 = 'VALUE'
  
 #Add new row to table
 `$table.Rows.Add(`$row)
"@
 }
 New-IseSnippet @snippet
 }

 #formatted duration snippet
 if(!$snips.Where{$_.Name -like 'Formatted Duration*'})
{
 $snippet = @{
 Title = 'Formatted Duration'
 Description = 'Formats Get-SQLAgentJobHistory into timespan'
 Text = @"
   `$FormattedDuration = @{
    Name       = 'FormattedDuration'
    Expression = {
      [timespan]`$_.RunDuration.ToString().PadLeft(6,'0').insert(4,':').insert(2,':')
    }
    }
"@
}
New-IseSnippet @snippet
}

if(!$snips.Where{$_.Name -like 'Prompt for*'})
{
$snippet = @{
 Title = 'Prompt for input'
 Description = 'Simple way of gathering input from users with simple yes and no'
 Text = @"
 	# Get some input from users  
	`$title = "Put your Title Here" 
	`$message = "Put Your Message here (Y/N)" 
	`$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Will continue" 
	`$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Will exit" 
	`$options = [System.Management.Automation.Host.ChoiceDescription[]](`$yes, `$no) 
	`$result = `$host.ui.PromptForChoice(`$title, `$message, `$options, 0) 
	 
	if (`$result -eq 1) 
    { Write-Output "User pressed no!"}
    elseif (`$result -eq 0) 
    { Write-Output "User pressed yes!"}
"@
}
New-IseSnippet @snippet
}

if(!$snips.Where{$_.Name -like 'Run SQL query with SMO*'})
{
$snippet = @{
 Title = 'Run SQL query with SMO'
 Description = 'creates SMO object and runs a sql command'
 Text = @"
`$srv = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList `$Server
`$SqlConnection = `$srv.ConnectionContext
`$SqlConnection.StatementTimeout = 8000
`$SqlConnection.ConnectTimeout = 10
`$SqlConnection.Connect()
`$Results = `$SqlConnection.ExecuteWithResults(`$Query).Tables
`$SqlConnection.Disconnect()
"@
}
New-IseSnippet @snippet
}

if(!$snips.Where{$_.Name -like 'SQL Assemblies*'})
{
$snippet = @{
 Title = 'SQL Assemblies'
 Description = 'SQL Assemblies'
 Text = @"
[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Management.Common" );
[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoEnum" );
[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Smo" );
[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoExtended " );
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfo") 
"@
}
New-IseSnippet $snippet
}

if(!$snips.Where{$_.Name -like 'Bulk copy from data table*'})
{
$snippet = @{
 Title = 'Bulk copy from data table'
 Description = 'Bulk copy from data table'
 Text =  @"
`$sqlserver = ''
`$database = ''
`$table = ''
`$batchsize = 5000



# Build the sqlbulkcopy connection, and set the timeout to infinite
`$connectionstring = "Data Source=`$sqlserver;Integrated Security=true;Initial Catalog=`$database;"
`$bulkcopy = New-Object Data.SqlClient.SqlBulkCopy(`$connectionstring, [System.Data.SqlClient.SqlBulkCopyOptions]::TableLock)
`$bulkcopy.DestinationTableName = `$table
`$bulkcopy.bulkcopyTimeout = 0
`$bulkcopy.batchsize = `$batchsize

`$bulkcopy.WriteToServer(`$datatable)
`$datatable.Clear()
"@
}
New-IseSnippet @snippet
}
if(!$snips.Where{$_.Name -like 'WSMan Test and CIM instead of WMI*'})
{
$snippet = @{
 Title = 'WSMan Test and CIM instead of WMI'
 Description = 'Creates a CiM Session depending on the results of the WSMan test'
 Text = @"
## Servername
`$Server = ''

## Test for WSMan
`$WSMAN = Test-WSMan `$Server

## Change Protocol if needed for CimSession

if(`$WSMAN.ProductVersion.Contains('Stack: 2.0'))
{
    `$opt = New-CimSessionOption -Protocol Dcom
    `$s = New-CimSession -ComputerName `$Server -SessionOption `$opt
}
else
{
    `$s = New-CimSession -ComputerName `$Server
}

## Do your funky CIM stuff
Get-CimInstance -ClassName Win32_OperatingSystem -CimSession `$s| select LastBootUpTime 
"@
}
New-IseSnippet @snippet
}

if(!$snips.Where{$_.Name -like 'Max Length of Datatable*'})
{
$snippet = @{
 Title = 'Max Length of Datatable'
 Description = 'Takes a datatable object and iterates through it to get the max length of the string columns - useful for data loads'
 Text = @"
`$columns = (`$datatable | Get-Member -MemberType Property).Name
foreach(`$column in `$Columns)
{
`$max = 0
    foreach (`$a in `$datatable)
    {
        if(`$max -lt `$a.`$column.length)
        {
            `$max = `$a.`$column.length
        }
    
    }
    Write-Output "`$column max length is `$max"
}

"@
}
New-IseSnippet @snippet
}


if(!$snips.Where{$_.Name -like 'Start a stopwatch*'})
{
$snippet = @{
 Title = 'Start a stopwatch'
 Description = 'Starts a stopwatch'
 Text = @"
 `$sw = [diagnostics.stopwatch]::StartNew()
"@
}
New-IseSnippet @snippet
}


if(!$snips.Where{$_.Name -like 'New Excel Object*'})
{
$snippet = @{
Title = "New Excel Object";
Description = "Creates a New Excel Object";
Text = @"
# Create a .com object for Excel
`$xl = new-object -comobject excel.application
`$xl.Visible = `$true # Set this to False when you run in production
`$wb = `$xl.Workbooks.Add() # Add a workbook
 
`$ws = `$wb.Worksheets.Item(1) # Add a worksheet
 
`$cells=`$ws.Cells

Do Some Stuff
 
perhaps
 
`$cells.item(`$row,`$col)="Server"
`$cells.item(`$row,`$col).font.size=16
`$Cells.item(`$row,`$col).Columnwidth = 10
`$col++

 
`$wb.Saveas("C:\temp\Test`$filename.xlsx")
`$xl.quit()
"@
}
New-IseSnippet @snippet
}


if(!$snips.Where{$_.Name -like 'SQL Authentication SMO*'})
{
 $snippet = @{
 Title = 'SQL Authentication SMO'
 Description = 'SQL Authentication SMO'
 Text = @"

`$sqllogin = Get-Credential 
`$srv = New-Object Microsoft.SqlServer.Management.Smo.Server `$server
`$srv.ConnectionContext.LoginSecure = `$false
`$srv.ConnectionContext.set_Login(`$sqllogin.username)
`$srv.ConnectionContext.set_SecurePassword(`$sqllogin.Password)
 
try 
{ 
`$srv.ConnectionContext.Connect() 
} 
catch 
{ 
throw "Can't connect to `$server or access denied. Quitting." 
}
"@
}
New-IseSnippet @snippet
}

if(!$snips.Where{$_.Name -like 'Simple Create Database*'})
{
$snippet = @{
 Title = 'Simple Create Database'
 Description = 'SImple SMO code to create a database'
 Text = @"
##Create a database
`$server = ''
`$DBName = 'TheBeardsDatabase'
`$db = New-Object Microsoft.SqlServer.Management.Smo.Database `$Server, `$DBName
`$db.Create()
"@
}
New-IseSnippet @snippet
}

if(!$snips.Where{$_.Name -like 'Create a database Role*'})
{
$snippet = @{
 Title = 'Create a database Role'
 Description = 'Simple SMO to create a Database Role'
 Text = @"
##Create a role
`$server = ''
`$DBName = ''
`$RoleName = ''
`$srv = New-Object Microsoft.SqlServer.Management.Smo.Server `$Server
`$db = `$srv.Databases[`$DBName]
`$Role = New-Object Microsoft.SqlServer.Management.Smo.DatabaseRole `$db, `$RoleName
`$Role.Create()

"@
}
New-IseSnippet @snippet
}