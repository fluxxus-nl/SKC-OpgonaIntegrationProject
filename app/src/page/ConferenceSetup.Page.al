page 50001 "Conference Setup ASD"
{
    PageType = Card;
    Caption = 'Conference Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    SourceTable = "Conference Setup ASD";


    layout
    {
        area(content)
        {
            group(NoSeries)
            {
                Caption = 'No.Series';
                field(ConferenceRegNos; Rec.ConferenceRegNos)
                {
                    ApplicationArea = All;
                }
                field(PostedConferenceRegNos; Rec.ConferencePostedRegNos)
                {
                    ApplicationArea = All;
                }
                field(ConferenceLocationNos; Rec.ConferenceLocationNos)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

}
