# PowerBI_Desktop_Export_CSV
a Powershell script to query and export a CSV  from Power BI Desktop  
download the ssas.ps1  
right click the file in windows, then open  
edit $query = “evaluate Table1”, write a dax query that refer to your model, then save  
right click the file in windows, then run with PowerShell, make sure only one Instance of PowerBI desktop is running.  
a new file “tofile.csv” will be generated  
