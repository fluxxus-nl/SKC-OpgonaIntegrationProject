page 50016 "Conference Activities ASD"
{
    Caption = 'Conference Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Conference Cue ASD";
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            cuegroup(Registrations)
            {
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                    DrillDownPageId = "Conference List ASD";
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved field.', Comment = '%';
                    DrillDownPageId = "Conference List ASD";
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Open field.', Comment = '%';
                    DrillDownPageId = "Conference List ASD";
                }
                field(Requested; Rec.Requested)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested field.', Comment = '%';
                    DrillDownPageId = "Conference List ASD";
                }
                actions
                {
                    action(New)
                    {
                        ApplicationArea = All;
                        Caption = 'New';
                        ToolTip = 'Create a new Conference registration.';
                        Image = TileNew;
                        RunObject = Page "Conference Card ASD";
                        RunPageMode = Create;
                    }
                }
            }
            cuegroup("For Posting")
            {
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.', Comment = '%';
                    DrillDownPageId = "Conference List ASD";
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SetupCues)
            {
                caption = 'Set Up Cues';
                tooltip = 'Set up Cues related to the role';
                image = Setup;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                    CueSetup: Codeunit "Cues And KPIs";
                begin
                    CueRecordRef.GetTable(Rec);
                    CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.Number());
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.InsertRecord();
    end;
}




