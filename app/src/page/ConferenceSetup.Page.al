page 50001 "ConferenceSetup ASD"
{
    PageType = Card;
    Caption = 'Conference Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    SourceTable = "ConferenceSetup ASD";


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
