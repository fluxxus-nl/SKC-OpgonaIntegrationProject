table 50002 "ConferenceRegHeader ASD"
{
    Caption = 'Conference Registration Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; DocumentNo; Code[20])
        {
            Caption = 'Document No.';
            Tooltip = 'Specifies the value of the Document No. field';
        }
        field(2; Customer; Code[20])
        {
            Caption = 'Customer';
            Tooltip = 'Specifies the value of the Customer field';
            TableRelation = Customer."No.";
        }
        field(3; ConferenceLocation; Code[20])
        {
            Caption = 'Conference Location';
            Tooltip = 'Specifies the value of the Conference Location field';
            //TableRelation to conference location
        }
        field(4; StartingDate; Date)
        {
            Caption = 'Starting Date';
            Tooltip = 'Specifies the value of the Starting Date field';
        }
        field(5; EndingDate; Date)
        {
            Caption = 'Ending Date';
            Tooltip = 'Specifies the value of the Ending Date field';
        }
        field(6; StartingTime; Time)
        {
            Caption = 'Starting Time';
            Tooltip = 'Specifies the value of the Starting Time field';
        }
        field(7; EndingTime; Time)
        {
            Caption = 'Ending Time';
            Tooltip = 'Specifies the value of the Ending Time field';
        }
        field(8; DocumentDate; Date)
        {
            Caption = 'Document Date';
            Tooltip = 'Specifies the value of the Document Date field';
        }
        field(9; PostingDate; Date)
        {
            Caption = 'Posting Date';
            Tooltip = 'Specifies the value of the Posting Date field';
        }
        field(10; NoAttendees; Integer)
        {
            Caption = 'No. of Attendees';
            Tooltip = 'Specifies the value of the No. of Attendees field';
        }
        field(11; Status; Enum "Status ASD")
        {
            Caption = 'Status';
            Tooltip = 'Specifies the value of the Status field';
        }
    }

    keys
    {
        key(Key1; DocumentNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}