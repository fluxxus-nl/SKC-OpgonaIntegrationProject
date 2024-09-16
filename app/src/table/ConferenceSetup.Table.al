table 50001 "ConferenceSetup ASD"
{
    Caption = 'Conference Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {

        }
        field(2; ConferenceRegNos; Code[10])
        {
            Caption = 'Conference Registration Nos.';
            ToolTip = 'Specifies the value of the Conference Registration Nos. field';
        }
        field(3; ConferencePostedRegNos; Code[10])
        {
            Caption = 'Posted Conference Registration Nos.';
            ToolTip = 'Specifies the value of the Posted Conference Registration Nos. field';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    internal procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    internal procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;


}