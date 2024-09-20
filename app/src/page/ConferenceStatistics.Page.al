page 50021 "Conference Statistics ASD"
{
    Caption = 'Conference Statistics';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Conference Location ASD";
    Editable = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            group(ThisPeriod)
            {
                caption = 'This Period';
                field(ConferenceDateName1; ConferenceDateName[1])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Number of Atendees[1]"; TotalAmount[1])
                {
                    Caption = 'Number of Ateendes';
                    ApplicationArea = All;
                }
                field("Number of Locations[1]"; NumberofParticipants[1])
                {
                    Caption = 'Number of Locations';
                    ApplicationArea = All;
                }
                field("Total Amount[1]"; NumberofParticipants[1])
                {
                    Caption = 'Total Amount';
                    ApplicationArea = All;
                }
            }
            group(ThisYear)
            {
                caption = 'This Year';
                field(ConferenceDateName2; ConferenceDateName[2])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Number of Atendees[2]"; TotalAmount[2])
                {
                    Caption = 'Number of Ateendes';
                    ApplicationArea = All;
                }
                field("Number of Locations[2]"; NumberofParticipants[2])
                {
                    Caption = 'Number of Locations';
                    ApplicationArea = All;
                }
                field("Total Amount[2]"; NumberofParticipants[2])
                {
                    Caption = 'Total Amount';
                    ApplicationArea = All;
                }
            }
            group(ThisLastYear)
            {
                caption = 'This Last Year';
                field(ConferenceDateName3; ConferenceDateName[3])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Number of Atendees[3]"; TotalAmount[3])
                {
                    Caption = 'Number of Ateendes';
                    ApplicationArea = All;
                }
                field("Number of Locations[3]"; NumberofParticipants[3])
                {
                    Caption = 'Number of Locations';
                    ApplicationArea = All;
                }
                field("Total Amount[3]"; NumberofParticipants[3])
                {
                    Caption = 'Total Amount';
                    ApplicationArea = All;
                }
            }
            group(Todate)
            {
                caption = 'To Date';
                field(ConferenceDateName4; ConferenceDateName[4])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Number of Atendees[4]"; TotalAmount[4])
                {
                    Caption = 'Number of Ateendes';
                    ApplicationArea = All;
                }
                field("Number of Locations[4]"; NumberofParticipants[4])
                {
                    Caption = 'Number of Locations';
                    ApplicationArea = All;
                }
                field("Total Amount[4]"; NumberofParticipants[4])
                {
                    Caption = 'Total Amount';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("No.", rec."No.");
        if CurrentDate <> WorkDate() then begin
            CurrentDate := WorkDate();
            DateFilterCalc.CreateAccountingPeriodFilter(ConferenceDateFilter[1], ConferenceDateName[1], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(ConferenceDateFilter[2], ConferenceDateName[2], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(ConferenceDateFilter[3], ConferenceDateName[3], CurrentDate, -1);
        end;
        for i := 1 to 4 do begin
            Rec.SetFilter("Document Date", ConferenceDateFilter[i]);
            Rec.CalcFields("Total Amount", "Number of Participants", "Number of Locations");
            TotalAmount[i] := Rec."Total Amount";
            NumberofLocations[i] := Rec."Number of Locations";
            NumberofParticipants[i] := rec."Number of Participants";
        end;
        Rec.SetRange("Document Date", 0D, CurrentDate);
    end;

    var
        DatefilterCalc: Codeunit "DateFilter-Calc";
        CurrentDate: Date;
        NumberofLocations: array[4] of Decimal;
        NumberofParticipants: array[4] of Decimal;
        TotalAmount: array[4] of Decimal;
        i: integer;
        ConferenceDateFilter: array[4] of text[30];
        ConferenceDateName: array[4] of text[30];
}