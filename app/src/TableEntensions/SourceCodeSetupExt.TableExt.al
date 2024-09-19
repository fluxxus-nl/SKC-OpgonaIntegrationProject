tableextension 50000 "Source Code Setup Ext ASD" extends "Source Code Setup"
{
    fields
    {
        field(7308; "Conference Location ASD"; Code[10])
        {
            Caption = 'Conference Location';
            TableRelation = "Source Code";
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}