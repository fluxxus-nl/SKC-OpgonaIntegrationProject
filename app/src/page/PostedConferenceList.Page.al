page 50014 "Posted Conference List ASD"
{
    Caption = 'Posted Conference List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Posted Conference Header ASD";
    CardPageId = "Posted Conference Card ASD";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lists)
            {
                Caption = 'Lists';

                field(DocumentNo; Rec.DocumentNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(ConferenceLocation; Rec.ConferenceLocation)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(NoAttendees; Rec.NoAttendees)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(StartingDate; Rec.StartingDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(EndingDate; Rec.EndingDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(DocumentDate; Rec.DocumentDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(PostingDate; Rec.PostingDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                ApplicationArea = All;
                Image = Post;
                Scope = Repeater;

                trigger OnAction()
                begin
                    Message('in progress');
                end;
            }
            action(FindEntries)
            {
                Caption = 'Find Entries';
                Tooltip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                image = Navigate;
                ShortcutKey = 'Shift+ctrl+I';
                trigger OnAction()
                var
                    Navigate: Page Navigate;
                begin
                    Navigate.SetDoc(Rec.PostingDate, Rec.DocumentNo);
                    Navigate.Run();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(Post_Promoted; Post) { }
                actionref(FEntries; Findentries) { }
            }
        }
    }
}