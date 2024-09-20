page 50000 "Conference Location List ASD"
{
    Caption = 'Conference Location';
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
                Caption = 'Create Conference Document';
                ToolTip = 'Specifies the Create Conference Document action';
                ApplicationArea = All;
                Scope = Repeater;
                Image = Create;

                trigger OnAction();
                var
                    ConferenceASD: record "Conference ASD";
                begin
                    if Rec."No." <> '' then begin
                        ConferenceASD.Init();
                        ConferenceASD.ConferenceLocation := Rec."No.";
                        if Rec."Unit Price" <> 0 then
                            ConferenceASD."Unit Price" := Rec."Unit Price";
                        ConferenceASD.Insert(true);
                        PAGE.Run(Page::"Conference Card ASD", ConferenceASD);
                    end;
                end;
            }
        }
    }
}