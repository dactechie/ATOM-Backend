--ALTER FUNCTION udf_getBitValueFromJSON(@json nvarchar(max), @key varchar(30))
--returns bit 
--as
--begin
--	declare @ret as bit;
--	declare @scalar as varchar(100);
	
--	set @scalar =   JSON_QUERY(@json, N'strict $.'+   @key  + '');  

--	--set @scalar = JSON_VALUE(@json, '$.HaveDVOrFamilySafetyConcerns');
--	if @scalar is not null
--		if @scalar = 'No'--"No",  -- "Yes (risk assessment required)"
--			set @ret  = 0 
--		else
--			set @ret = 1

--	return @ret
--end

DECLARE @json nvarchar(max);
DECLARE @b bit;

set @json = '{"ClientType":"ownuse","Anyodc": "yes", "HaveDVOrFamilySafetyConcerns":"Yes - in the past 4 weeks (risk assessment required)"}'


exec @b = dbo.udf_getBitValueFromJSON @json=@json, @key='HaveDVOrFamilySafetyConcerns';

select @b;

