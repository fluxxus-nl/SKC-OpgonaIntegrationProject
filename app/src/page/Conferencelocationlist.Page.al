page 50000 "Conferencelocationlist ASD"
{
    Caption = 'Conference Location List';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Conference Location ASD";
    CardPageId = "Conference Location Card ASD";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {
            systempart(Links; Links) { }
            systempart(Notes; Notes) { }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateConferenceDocument)
            {
                Caption = 'Create Conference Document (TEST)';
                ToolTip = 'Specifies the Create Conference Document action';
                ApplicationArea = All;
                Scope = Repeater;
                Image = Create;

                trigger OnAction();
                begin
                    Message('in progress');
                end;
            }
        }
    }
}