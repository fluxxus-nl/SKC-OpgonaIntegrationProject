page 50013 "Posted Conference Lines ASD"
{
    Caption = 'Posted Conference Lines';
    PageType = ListPart;
    ApplicationArea = All;
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    SourceTable = "Posted Conference Line ASD";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(type; Rec."type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                    ValuesAllowed = 0, 1;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of measure code field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.', Comment = '%';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the value of the Line Discount % field.', Comment = '%';
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Discount Amount field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field(Registered; Rec.Registered)
                {
                    ToolTip = 'Specifies the value of the Registered field.', Comment = '%';
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ToolTip = 'Specifies the value of the Registration Date field.', Comment = '%';
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ToolTip = 'Specifies the value of the To Invoice field.', Comment = '%';
                }
            }
        }
    }
}