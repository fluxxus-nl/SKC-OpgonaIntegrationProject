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
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
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
                Image = CreateDocument;

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
            action(Statistics)
            {
                Caption = 'Statistics';
                ToolTip = 'View Statistical Information';
                image = Statistics;
                RunObject = Page "Conference Statistics ASD";
                RunPageLink = ConferenceLocation = field("No."), PostingDate = field("Date Filter");
                ShortcutKey = 'f7';
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Category_Process';
                actionref(Create_Promoted; CreateConferenceDocument) { }
                actionref(Statistics_action; Statistics) { }
            }
        }
    }
}