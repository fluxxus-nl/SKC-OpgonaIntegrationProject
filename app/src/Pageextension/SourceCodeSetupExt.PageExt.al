pageextension 50000 "Source Code Setup Ext ASD" extends "Source Code Setup"
{
    layout
    {
        addafter("Resources")
        {
            group("Conference ASD")
            {
                Visible = true;
                Caption = 'Conference';
                field("Conference Location ASD"; Rec."Conference Location ASD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Conference Location Source Code.', Comment = '%';
                }
            }
        }
    }
}