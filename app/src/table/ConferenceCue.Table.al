table 50012 "Conference Cue ASD"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';
        }
        field(2; Open; Integer)
        {
            Caption = 'Open';
            FieldClass = FlowField;
            CalcFormula = count("Conference ASD" where(Status = const(Open)));
        }
        field(3; Requested; Integer)
        {
            Caption = 'Requested';
            FieldClass = FlowField;
            CalcFormula = count("Conference ASD" where(Status = const(Requested)));
        }
        field(4; Approved; Integer)
        {
            Caption = 'Approved';
            FieldClass = FlowField;
            CalcFormula = count("Conference ASD" where(Status = const(Approved)));
        }
        field(5; Active; Integer)
        {
            Caption = 'Active';
            FieldClass = FlowField;
            CalcFormula = count("Conference ASD" where(Status = const(Active)));
        }
        field(6; Closed; Integer)
        {
            Caption = 'Closed';
            FieldClass = FlowField;
            CalcFormula = count("Conference ASD" where(Status = const(Closed)));
        }
        field(7; Canceled; Integer)
        {
            Caption = 'Canceled';
            FieldClass = FlowField;
            CalcFormula = count("Conference ASD" where(Status = const(Canceled)));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure Insertrecord()
    begin
        if not Rec.FindFirst() then
            Rec.Insert();
    end;

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