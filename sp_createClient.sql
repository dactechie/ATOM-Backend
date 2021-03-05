CREATE PROCEDURE sp_createClient ( @SLK varchar(14), @ClientID int output)
as 
begin
	insert into Client (SLK) values (@SLK)
	set @ClientID = 1
end