tableextension 50000 "Source Code Setup Ext ASD" extends "Source Code Setup"
{
    fields
    {
        field(50000; "Conference Location ASD"; Code[10])
        {
            Caption = 'Conference Location';
            TableRelation = "Source Code";
        }
    }
}