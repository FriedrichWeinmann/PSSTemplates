$action = {
    param (
        $Parameters
    )
	
    $rootPath = $Parameters.RootPath
    $actualParameters = $Parameters.Parameters
	
    #TODO: Implement Action
}

$params = @{
    Name        = '%FileTitle%'
    Action      = $action
    Description = 'Does Something'
    Parameters  = @{
        Param1 = '(mandatory) Whatever the first parameter does.'
        Param2 = 'Whatever the second parameter does.'
    }
}

Register-PSMDBuildAction @params