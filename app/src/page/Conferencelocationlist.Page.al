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
                Caption = 'Create New Conference Document';
                ToolTip = 'Specifies the Create Conference Document action';
                ApplicationArea = All;
                Scope = Repeater;
                Image = NewSalesInvoice;
                RunObject = page "Conference Card ASD";

                trigger OnAction();
                var
                    conference: record "Conference ASD";
                begin
                    if Rec."No." <> '' then begin
                        Conference.Init();
                        Conference.ConferenceLocation := Rec."No.";
                        if Rec."Unit Price" <> 0 then
                            conference."Unit Price" := Rec."Unit Price";
                        Conference.Insert(true);
                        PAGE.Run(Page::"Conference Card ASD", Conference);
                    end;
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Create';
                actionref(Create; CreateConferenceDocument) { }
            }
        }
    }
}