page 50014 "Posted Conference List ASD"
{
    Caption = 'Posted Conference';
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(CustomerName; Rec.CustomerName)
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field(PostingDate; Rec.PostingDate)
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
                field(StartingTime; Rec.StartingTime)
                {
                    ToolTip = 'Specifies the value of the Starting Time field.', Comment = '%';
                }
                field(EndingTime; Rec.EndingTime)
                {
                    ToolTip = 'Specifies the value of the Ending Time field.', Comment = '%';
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                }
                field("Total Price"; Rec."Total Price")
                {
                    ToolTip = 'Specifies the value of the Total Price field.', Comment = '%';
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