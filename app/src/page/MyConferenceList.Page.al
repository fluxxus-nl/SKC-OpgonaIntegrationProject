page 50017 "My Conference List ASD"
{
    Caption = 'My Conferences';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "My Conference ASD";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Conference No."; rec."Conference No.")
                {
                    caption = 'Conference No.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        GetConference();
                    end;
                }
                field(ConferenceName; Conference.ConferenceLocation)
                {
                    caption = 'Conference Name';
                    ApplicationArea = All;
                }
                field(ConferenceDuration; Conference.Duration)
                {
                    caption = 'Conference Duration';
                    ApplicationArea = All;
                }
                field(ConferencePrice; Conference."Unit Price")
                {
                    caption = 'Conference Price';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Open)
            {
                caption = 'Open';
                ToolTip = 'Open the card for the selected record.';
                ApplicationArea = basic;
                image = Edit;
                ShortcutKey = 'Return';
                trigger OnAction();
                begin
                    OpenConferenceCard();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID", UserId());
    end;

    trigger OnAfterGetRecord()
    begin
        GetConference();
    end;

    trigger OnNewRecord(Belowxrec: Boolean);
    begin
        Clear(Conference);
    end;

    var
        Conference: record "Conference ASD";

    local procedure GetConference(): Boolean
    begin
        Clear(Conference);
        exit(Conference.Get(Rec."Conference No."));
    end;

    procedure OpenConferenceCard();
    begin
        if GetConference() then
            Page.Run(Page::"Conference Card ASD", Conference);
    end;
}