#  the idea of extracting the port number and the database name  is discussed here http://www.thebiccountant.com/2016/04/09/hackpowerbi/
#  Mimoune Djouallah my role was just to use write this script to extract the port number and the database name, M is much easier than PS script. 


$pathtofile = (Get-ChildItem -Path c:\users -Filter msmdsrv.port.txt -Recurse -ErrorAction SilentlyContinue -Force).FullName
"pathtofile" + $pathtofile
$port = gc $pathtofile
$port = $port -replace '\D',''
$dataSource = "localhost:$port"
"dataSource :" + $dataSource

$pathtoDataBase_Name = $pathtofile -replace 'msmdsrv.port.txt',''
	


$Database_Name = Get-ChildItem -Path $pathtoDataBase_Name -Filter *.db.xml -Recurse -ErrorAction SilentlyContinue -Force



$Database_Name = $Database_Name.ToString().Split(".") | select -First 1

"Database_Name :" + $Database_Name


# the code is from this web site http://www.kasperonbi.com/dump-the-results-of-a-dax-query-to-csv-using-powershell/

$connectionString = "Provider=MSOLAP;Data Source=$dataSource;Initial Catalog=$Database_Name;"
$query = "evaluate Table1"

$filename = "tofile.csv"
 
$connection = New-Object -TypeName System.Data.OleDb.OleDbConnection

$connection.ConnectionString = $connectionString
$command = $connection.CreateCommand()
$command.CommandText = $query
$adapter = New-Object -TypeName System.Data.OleDb.OleDbDataAdapter $command
$dataset = New-Object -TypeName System.Data.DataSet
$adapter.Fill($dataset)

$dataset.Tables[0] | export-csv $filename -notypeinformation
   
$connection.Close()
