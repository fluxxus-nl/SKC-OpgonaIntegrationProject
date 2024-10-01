page 50021 "Conference Statistics ASD"
{
    Caption = 'Conference Statistics';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Conference ASD";
    Editable = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            group(ThisPeriod)
            {
                caption = 'This Period';
                field(conferenceDateName1; conferenceDateName[1])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("TotalPrice[1]"; TotalPrice[1])
                {
                    Caption = 'Total Price';
                    ApplicationArea = All;
                }
                field("NoAtendees[1]"; NoAteendees[1])
                {
                    Caption = 'No. Atendees';
                    ApplicationArea = All;
                }
                field("NoConferences[1]"; NoConferences[1])
                {
                    Caption = 'No. Conferences';
                    ApplicationArea = All;
                }
            }
            group(ThisYear)
            {
                caption = 'This Year';
                field("conferenceDateName[2]"; conferenceDateName[2])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("TotalPrice[2]"; TotalPrice[2])
                {
                    Caption = 'Total Price';
                    ApplicationArea = All;
                }
                field("NoAtendees[2]"; NoAteendees[2])
                {
                    Caption = 'No. Atendees';
                    ApplicationArea = All;
                }
                field("NoConferences[2]"; NoConferences[2])
                {
                    Caption = 'No. Conferences';
                    ApplicationArea = All;
                }
            }
            group(ThisLastYear)
            {
                caption = 'This Last Year';
                field("conferenceDateName[3]"; conferenceDateName[3])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("TotalPrice[3]"; TotalPrice[3])
                {
                    Caption = 'Total Price';
                    ApplicationArea = All;
                }
                field("NoAtendees[3]"; NoAteendees[3])
                {
                    Caption = 'No. Atendees';
                    ApplicationArea = All;
                }
                field("NoConferences[3]"; NoConferences[3])
                {
                    Caption = 'No. Conferences';
                    ApplicationArea = All;
                }
            }
            group(Todate)
            {
                caption = 'To Date';
                field("conferenceDateName[4]"; conferenceDateName[4])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("TotalPrice[4]"; TotalPrice[4])
                {
                    Caption = 'Total Price';
                    ApplicationArea = All;
                }
                field("NoAtendees[4]"; NoAteendees[4])
                {
                    Caption = 'No. Atendees';
                    ApplicationArea = All;
                }
                field("NoConferences[4]"; NoConferences[4])
                {
                    Caption = 'No. Conferences';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange(DocumentNo, Rec.DocumentNo);
        DateFilterCalc.CreateAccountingPeriodFilter(conferenceDateFilter[1], conferenceDateName[1], WorkDate(), 0);
        DateFilterCalc.CreateFiscalYearFilter(conferenceDateFilter[2], conferenceDateName[2], WorkDate(), 0);
        DateFilterCalc.CreateFiscalYearFilter(conferenceDateFilter[3], conferenceDateName[3], WorkDate(), -1);
        for i := 1 to 4 do begin
            Rec.SetFilter("Date Filter", conferenceDateFilter[i]);
            Rec.CalcFields(TotalPriceStatistics, NoAttendeesStatistics, NoConferencesStatistics);
            TotalPrice[i] := Rec.TotalPriceStatistics;
            NoAteendees[i] := rec.NoAttendeesStatistics;
            NoConferences[i] := rec.NoConferencesStatistics;
        end;
        Rec.SetRange("Date Filter", 0D, WorkDate());
    end;

    var
        DatefilterCalc: Codeunit "DateFilter-Calc";
        CurrentDate: Date;
        TotalPrice: array[4] of Decimal;
        NoAteendees: array[4] of Integer;
        NoConferences: array[4] of Integer;
        i: integer;
        conferenceDateFilter: array[4] of text[30];
        conferenceDateName: array[4] of text[30];
}
