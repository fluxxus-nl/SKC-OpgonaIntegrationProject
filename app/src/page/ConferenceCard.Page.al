page 50003 "Conference Card ASD"
{
    Caption = 'Conference';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Conference ASD";
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
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                    Editable = true;
                    ShowMandatory = true;
                }
                field(CustomerName; Rec.CustomerName)
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field(ConferenceLocation; Rec.ConferenceLocation)
                {
                    ApplicationArea = All;
                    Editable = true;
                    LookupPageId = "Conference Location List ASD";
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        blockconferenceline();
                    end;
                }
                field(DocumentDate; Rec.DocumentDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                    ShowMandatory = true;
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
                    ShowMandatory = true;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ShowMandatory = true;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Unit Price field.', Comment = '%';
                }
                field("Total Price"; Rec."Total Price")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Total Price field.', Comment = '%';
                }
            }

            part(ConferenceRegistrationLines; "Conference Lines ASD")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field(DocumentNo);
                Editable = blockLines;
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
                    Visible = false;
                }
                field(StartingTime; Rec.StartingTime)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(EndingTime; Rec.EndingTime)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NoAttendees; Rec.NoAttendees)
                {
                    ApplicationArea = All;
                    Editable = true;
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
            action(Post)
            {
                Caption = 'Post';
                ToolTip = 'Specifies the Post Action';
                Image = Post;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ConferenceJnlPostLineASD: Codeunit "Conference Jnl.-Post Line ASD";
                    ConferenceDocumentMgmtASD: Codeunit "Conference Document Mgmt ASD";
                begin
                    Rec.TestStatusOpen();
                    ConferenceJnlPostLineASD.Run(Rec);
                    ConferenceDocumentMgmtASD.TransferConferenceDocument(Rec);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(Post_Promoted; Post) { }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        SourceCodeSetup: Record "Source Code Setup";
    begin
        if Rec."Source Code" = '' then begin
            SourceCodeSetup.Get();
            Rec."Source Code" := SourceCodeSetup."Conference Location ASD";
            Rec.Modify();
        end;
    end;

    procedure blockconferenceline()
    begin
        blockLines := false;
        if Rec.ConferenceLocation <> '' then
            blockLines := true;
    end;

    var
        blockLines: Boolean;
}