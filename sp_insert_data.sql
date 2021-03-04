alter PROCEDURE Masterinsertupdatedelete
  (
  @clientType    VARCHAR(10),
  @assessmentDate varchar(10),
  @program varchar(20),
  @childprot varchar(3),
  @injected varchar(3)
)
AS
BEGIN
  DECLARE @client bit = 0,
          @assessmentD datetime = CONVERT(DATETIME, @assessmentDate, 102),
          @programId smallint,
          @childp bit = 0,
          @everInjected bit = 0;

  select @programId=P.ID
  from Program P
  where P.[Name] = @program

  if @clientType = 'othersuse' begin
    set @client = 1
  end
  if @childprot = 'Yes' begin
    set @childp = 1
  end
  if @injected = 'Yes' begin
    set @everInjected = 1
  end
  insert into ClientCOMSRecord
    (ClientType, AssessmentDate, ProgramId, ChildProtectionConcerns, HaveYouEverInjected)
  values
    (@client, @assessmentD, @programId, @childp, @everInjected)
END;

-- exec Masterinsertupdatedelete @clientType = 'ownuse', @assessmentDate = '2021-02-20', @program = "Bega";


select *
from ClientCOMSRecord;

SELECT name
  FROM sys.columns
  WHERE [object_id] = OBJECT_ID('dbo.SDSEntry');

-- exec sp_columns SDSEntry