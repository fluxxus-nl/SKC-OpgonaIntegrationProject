table 50013 "My Conference ASD"
{
    DataClassification = ToBeClassified;
    Caption = 'My Conference';

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'User ID';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(2; "Conference No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Conference No.';
            TableRelation = "Conference ASD";
        }
    }

    keys
    {
        key(PK; "User ID", "Conference No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

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