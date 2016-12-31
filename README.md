# PowerBI_Desktop_Export_CSV
a Powershell script to query and export a CSV  from Power BI Desktop  
download the ssas.ps1  
right click the file in windows, then open  
edit $query = “evaluate Table1”, write a dax query that refer to your model, then save  
right click the file in windows, then run with PowerShell, make sure only one Instance of PowerBI desktop is running.  
a new file “tofile.csv” will be generated  
it seems SSAS embeded with PowerBI desktop is configured to time out after 30 Seconds, so if you are trying to export very large datasets try to do the export by a smaller chunck, I test it with a 3 Mi tables and it does work    
some people notice an improvement when they change the export file from csv to txt  
