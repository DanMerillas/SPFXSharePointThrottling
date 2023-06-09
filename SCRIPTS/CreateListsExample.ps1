#Config Variables
$SiteURL = Read-Host -Prompt 'Enter SharePoint URL'
$ListNameNormal = "NormalList"
$ListNameLarge = "LargeList"
$ListNameLargeWithColumnIndex = "LargeListWithColumnIndex"
$ListNameVeryLarge = "VeryLargeList"
$Template ="GenericList"


 
Try {
    #Connect to PnP Online
    Connect-PnPOnline -Url $SiteURL -Interactive
 
    #sharepoint online create list pnp powershell
    New-PnPList -Title $ListNameNormal -Template $Template -ErrorAction Stop
    Write-host "List '$ListNameNormal' Created Successfully!" -f Green

    New-PnPList -Title $ListNameLarge -Template $Template -ErrorAction Stop
    Write-host "List '$ListNameLarge' Created Successfully!" -f Green

    New-PnPList -Title $ListNameLargeWithColumnIndex -Template $Template -ErrorAction Stop
    Write-host "List '$ListNameLargeWithColumnIndex' Created Successfully!" -f Green

    New-PnPList -Title $ListNameVeryLarge -Template $Template -ErrorAction Stop
    Write-host "List '$ListNameVeryLarge' Created Successfully!" -f Green

    #Insert Lists Data

    #Create a New Batch
    $Batch = New-PnPBatch
 
    #Add List Items Normal list
    For ($i = 1; $i -le 50; $i++) {
        Add-PnPListItem -List $ListNameNormal -Values @{"Title" = "Value1" } -Batch $Batch
    }

    For ($i = 1; $i -le 20; $i++) {
        Add-PnPListItem -List $ListNameNormal -Values @{"Title" = "Value2" } -Batch $Batch
    }
 
    #Send Batch to the server
    Invoke-PnPBatch -Batch $Batch

    Write-host "List '$ListNameNormal': Items Created Successfully!" -f Green

    
    #Add List Items Large list
    For ($i = 1; $i -le 2501; $i++) {
        Add-PnPListItem -List $ListNameLarge -Values @{"Title" = "Value1" } -Batch $Batch
    }

    For ($i = 1; $i -le 2500; $i++) {
        Add-PnPListItem -List $ListNameLarge -Values @{"Title" = "Value2" } -Batch $Batch
    }
 
    #Send Batch to the server
    Invoke-PnPBatch -Batch $Batch


    #Add List Items Large list
    For ($i = 1; $i -le 2501; $i++) {
        Add-PnPListItem -List $ListNameLargeWithColumnIndex -Values @{"Title" = "Value1" } -Batch $Batch
    }

    For ($i = 1; $i -le 2500; $i++) {
        Add-PnPListItem -List $ListNameLargeWithColumnIndex -Values @{"Title" = "Value2" } -Batch $Batch
    }
 
    #Send Batch to the server
    Invoke-PnPBatch -Batch $Batch



    Write-host "List '$ListNameLarge': Items Created Successfully!" -f Green



    #Add List Items Large list
    For ($i = 1; $i -le 6000; $i++) {
        Add-PnPListItem -List $ListNameVeryLarge -Values @{"Title" = "Value1" } -Batch $Batch
    }

    For ($i = 1; $i -le 4000; $i++) {
        Add-PnPListItem -List $ListNameVeryLarge -Values @{"Title" = "Value2" } -Batch $Batch
    }
 
    #Send Batch to the server
    Invoke-PnPBatch -Batch $Batch
    Write-host "List '$ListNameVeryLarge': Items Created Successfully!" -f Green



    #Get the Context
    $Context = Get-PnPContext
    $ColumnName = "Title"
    
    #Get the Field from List
    $Field = Get-PnPField -List $ListNameLargeWithColumnIndex -Identity $ColumnName
    
    #Set the Indexed Property of the Field
    $Field.Indexed = $True
    $Field.Update() 
    $Context.ExecuteQuery() 

    Write-host "List '$ListNameLargeWithColumnIndex': column index Created Successfully!" -f Green


    #Get the Field from List
    $Field = Get-PnPField -List $ListNameVeryLarge -Identity $ColumnName
    
    #Set the Indexed Property of the Field
    $Field.Indexed = $True
    $Field.Update() 
    $Context.ExecuteQuery() 

    Write-host "List '$ListNameVeryLarge': column index Created Successfully!" -f Green

}
catch {
    write-host "Error: $($_.Exception.Message)" -foregroundcolor Red
}

