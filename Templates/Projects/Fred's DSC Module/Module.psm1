enum Ensure
{
    Absent
    Present
}

<#
	This resource manages the file in a specific path.
	[DscResource()] indicates the class is a DSC resource
#>

[DscResource()]
class %ProjectName%
{
    <#
		This property is the fully qualified path to the file that is
		expected to be present or absent.

		The [DscProperty(Key)] attribute indicates the property is a
		key and its value uniquely identifies a resource instance.
		Defining this attribute also means the property is required
		and DSC will ensure a value is set before calling the resource.

		A DSC resource must define at least one key property.
    #>
    [DscProperty(Key)]
    [string]$Path

    <#
		This property indicates if the settings should be present or absent
		on the system. For present, the resource ensures the file pointed
		to by $Path exists. For absent, it ensures the file point to by
		$Path does not exist.

		The [DscProperty(Mandatory)] attribute indicates the property is
		required and DSC will guarantee it is set.

		If Mandatory is not specified or if it is defined as
		Mandatory=$false, the value is not guaranteed to be set when DSC
		calls the resource. This is appropriate for optional properties.
    #>
    [DscProperty(Mandatory)]
    [Ensure] $Ensure

    <#
		Example for a mandatory property
    #>
    [DscProperty(Mandatory)]
    [string] $Something

    <#
		[DscProperty(NotConfigurable)] attribute indicates the property is
		not configurable in DSC configuration. Properties marked this way
		are populated by the Get() method to report additional details
		about the resource when it is present.
    #>
    [DscProperty(NotConfigurable)]
    [Nullable[datetime]] $SomethingReadOnly

    <#
		This method is equivalent of the Set-TargetResource script function.
		It sets the resource to the desired state.
    #>
    [void] Set()
    {
        # Apply logic here
    }

    <#
		This method is equivalent of the Test-TargetResource script function.
		It should return True or False, showing whether the resource
		is in a desired state.
    #>
    [bool] Test()
    {
		$test = $false
		
		# Insert test logic here
	
        return $test
    }

    <#
		This method is equivalent of the Get-TargetResource script function.
		The implementation should use the keys to find appropriate resources.
		This method returns an instance of this class with the updated key
		properties.
    #>
    [%ProjectName%] Get()
    {
        return $this
    }

    <#
		Helper method returns something
    #>
    [bool] TestSomething([string] $Something)
    {
        $present = $true

        # Insert logic

        return $present
    }

    <#
		Helper method does something without returning anything
    #>
    [void] DoSomething()
    {
        # Insert logic
    }
}