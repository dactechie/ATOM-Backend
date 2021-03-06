CREATE PROCEDURE sp_createClient ( @SLK varchar(14), @ClientID int output)
as 
begin
 
	select @ClientID = ID from Client where SLK = @SLK
	IF @ClientID is null
	 	BEGIN
			DECLARE @IDs TABLE(ID INT);
			DECLARE @datestring as varchar(10);
			-- ABCDE123456781
			set @datestring = SUBSTRING(@SLK, 6, 8);

			insert into Client (SLK, DOB, Sex) 
			OUTPUT inserted.ID INTO @IDs(ID)
			values (
				@SLK,
				CONVERT(date,
						SUBSTRING(@datestring, 5, 4) 
						+ SUBSTRING(@datestring, 3, 2) 
						+ SUBSTRING(@datestring, 1, 2)
				),
				CAST(SUBSTRING(@SLK, 14, 1) as TINYINT)
			)
			SELECT @ClientID = ID FROM @IDs;
		END
	
end