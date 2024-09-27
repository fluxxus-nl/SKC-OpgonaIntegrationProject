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
                field("TotalPriceNotChargeable[1]"; TotalPriceNotChargeable[1])
                {
                    Caption = 'Total Price (Not Chargeable)';
                    ApplicationArea = All;
                }
                field("TotalPriceChargeable[1]"; TotalPriceChargeable[1])
                {
                    Caption = 'Total Price (Chargeable)';
                    ApplicationArea = All;
                }
            }
            group(ThisYear)
            {
                caption = 'This Year';
                field(conferenceDateName2; conferenceDateName[2])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("TotalPrice[2]"; TotalPrice[2])
                {
                    Caption = 'Total Price';
                    ApplicationArea = All;
                }
                field("TotalPriceNotChargeable[2]"; TotalPriceNotChargeable[2])
                {
                    Caption = 'Total Price (Not Chargeable)';
                    ApplicationArea = All;
                }
                field("TotalPriceChargeable[2]"; TotalPriceChargeable[2])
                {
                    Caption = 'Total Price (Chargeable)';
                    ApplicationArea = All;
                }
            }
            group(ThisLastYear)
            {
                caption = 'This Last Year';
                field(conferenceDateName3; conferenceDateName[3])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("TotalPrice[3]"; TotalPrice[3])
                {
                    Caption = 'Total Price';
                    ApplicationArea = All;
                }
                field("TotalPriceNotChargeable[3]"; TotalPriceNotChargeable[3])
                {
                    Caption = 'Total Price (Not Chargeable)';
                    ApplicationArea = All;
                }
                field("TotalPriceChargeable[3]"; TotalPriceChargeable[3])
                {
                    Caption = 'Total Price (Chargeable)';
                    ApplicationArea = All;
                }
            }
            group(Todate)
            {
                caption = 'To Date';
                field(conferenceDateName4; conferenceDateName[4])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("TotalPrice[4]"; TotalPrice[4])
                {
                    Caption = 'Total Price';
                    ApplicationArea = All;
                }
                field("TotalPriceNotChargeable[4]"; TotalPriceNotChargeable[4])
                {
                    Caption = 'Total Price (Not Chargeable)';
                    ApplicationArea = All;
                }
                field("TotalPriceChargeable[4]"; TotalPriceChargeable[4])
                {
                    Caption = 'Total Price (Chargeable)';
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
        Rec.SetRange(DocumentDate, Rec.DocumentDate);
        if CurrentDate <> WorkDate() then begin
            CurrentDate := WorkDate();
            DateFilterCalc.CreateAccountingPeriodFilter(conferenceDateFilter[1], conferenceDateName[1], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(conferenceDateFilter[2], conferenceDateName[2], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(conferenceDateFilter[3], conferenceDateName[3], CurrentDate, -1);
        end;
        for i := 1 to 4 do begin
            Rec.SetFilter(DocumentDate, conferenceDateFilter[i]);
            Rec.CalcFields("Total Price", "Unit Price");
            TotalPrice[i] := Rec."Total Price";
            TotalPriceNotChargeable[i] := Rec."Unit Price";
        end;
        Rec.SetRange(DocumentDate, 0D, CurrentDate);
    end;

    var
        DatefilterCalc: Codeunit "DateFilter-Calc";
        CurrentDate: Date;
        TotalPrice: array[4] of Decimal;
        TotalPriceChargeable: array[4] of Decimal;
        TotalPriceNotChargeable: array[4] of Decimal;
        i: integer;
        conferenceDateFilter: array[4] of text[30];
        conferenceDateName: array[4] of text[30];
}