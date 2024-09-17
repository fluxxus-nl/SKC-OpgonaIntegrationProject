page 50003 "ConferenceRegHeaderCard ASD"
{
    Caption = 'Conference Registration';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ConferenceRegHeader ASD";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
                field(StartingTime; Rec.StartingTime)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(EndingTime; Rec.EndingTime)
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
                field(NoAttendees; Rec.NoAttendees)
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
            part(ConferenceRegistrationLines; "ConferenceReglinesubpage ASD")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field(DocumentNo);
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
                ToolTip = 'Specifies the Post Action';
                Image = Post;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Message('in progress');
                end;
            }
        }
    }
}