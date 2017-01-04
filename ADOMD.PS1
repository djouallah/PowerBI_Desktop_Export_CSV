#  Mimoune Djouallah my role was just to write this script to extract the port number and the database name, M is much easier than PS script. 

#  The idea of extracting the port number and the database name  is discussed here http://www.thebiccountant.com/2016/04/09/hackpowerbi/



# get the server name and the port name of PowerBI desktop SSAS 

$pathtofile = (Get-ChildItem -Path c:\users -Filter msmdsrv.port.txt -Recurse -ErrorAction SilentlyContinue -Force).FullName
$port = gc $pathtofile
$port = $port -replace '\D',''
$dataSource = "localhost:$port"
$pathtoDataBase_Name = $pathtofile -replace 'msmdsrv.port.txt',''
$Database_Name = Get-ChildItem -Path $pathtoDataBase_Name -Filter *.db.xml -Recurse -ErrorAction SilentlyContinue -Force
$Database_Name = $Database_Name.ToString().Split(".") | select -First 1


$query = "evaluate Table1"



# Connect using ADOMD.NET
#Another option is to use SQL_AS_ADOMD 2016, YOU CAN DOWNLOAD IT FROM HERE
#https://www.microsoft.com/en-us/download/details.aspx?id=52676

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.AnalysisServices.AdomdClient") 
#[Microsoft.AnalysisServices.AdomdClient.AdomdConnection]  
 
# Create the first connection object  
$con = new-object Microsoft.AnalysisServices.AdomdClient.AdomdConnection 
$con.ConnectionString = "Datasource=$dataSource; Initial Catalog=$Database_Name;timeout=0; connect timeout =0" 
$con.Open() 

"Datasource= " +$dataSource
"Database_Name= " +$Database_Name

$filename = "Table1.csv"

 
# Create a command and send a query 
$command = $con.CreateCommand()
$command.CommandText = $query

 
$adapter = New-Object -TypeName Microsoft.AnalysisServices.AdomdClient.AdomdDataAdapter $command
$dataset = New-Object -TypeName System.Data.DataSet
$adapter.Fill($dataset)

$dataset.Tables[0] | export-csv $filename -notypeinformation
   


 
# Close the first connection 
$con.Close() 
