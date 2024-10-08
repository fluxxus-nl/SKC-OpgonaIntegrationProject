page 50012 "Posted Conference Card ASD"
{
    Caption = 'Posted Conference Card';
    PageType = Document;
    ApplicationArea = All;
    SourceTable = "Posted Conference Header ASD";
    RefreshOnActivate = true;
    Editable = false;

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
                    LookupPageId = "Conference Location List ASD";
                }
                field(DocumentDate; Rec.DocumentDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(PostingDate; Rec.PostingDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.', Comment = '%';
                }
                field("Total Price"; Rec."Total Price")
                {
                    ToolTip = 'Specifies the value of the Total Price field.', Comment = '%';
                }
            }
            part(ConferenceRegistrationLines; "Posted Conference Lines ASD")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field(DocumentNo);
            }
            group(Booking)
            {
                field(StartingDate; Rec.StartingDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(EndingDate; Rec.EndingDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field(StartingTime; Rec.StartingTime)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(EndingTime; Rec.EndingTime)
                {
                    ApplicationArea = All;
                }
                field(NoAttendees; Rec.NoAttendees)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                    ApplicationArea = All;
                }

            }
            group("Invoice Details")
            {
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
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
                    Navigate.SetRec(Rec);
                    Navigate.Run();
                end;
            }

        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(FEntries; Findentries) { }
            }
        }
    }
}