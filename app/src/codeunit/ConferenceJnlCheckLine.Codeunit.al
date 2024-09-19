codeunit 50000 "Conference Jnl.-Check Line ASD"
{
    TableNo = "Conference ASD";

    var
        ConferenceLineASD: Record "Conference Line ASD";

    trigger OnRun()
    begin
        DoCheck(Rec, ConferenceLineASD); // Do the checks here
    end;

    internal procedure DoCheck(ConferenceASD: Record "Conference ASD"; ConferenceLineASD: Record "Conference Line ASD")
    begin
        ConferenceASD.TestField(DocumentNo);
        ConferenceASD.TestField(PostingDate);
        ConferenceASD.TestField(DocumentDate);
        ConferenceLineASD.TestField("Gen. Prod. Posting Group");
        ConferenceLineASD.TestField("Gen. Bus. Posting Group");
        case ConferenceLineASD.type of
            ConferenceLineASD.type::Item:
                ConferenceLineASD.TestField("No.");
            ConferenceLineASD.type::Resource:
                ConferenceLineASD.TestField("No.");
        end;
        ConferenceLineASD.TestField("No.");
        ConferenceLineASD.TestField(Description);
        ConferenceLineASD.TestField(Quantity);
        ConferenceLineASD.TestField("Unit of Measure Code");
        ConferenceLineASD.TestField("Unit Price");
        ConferenceLineASD.TestField(Amount);
        ConferenceLineASD.TestField("Line Discount %");
        ConferenceLineASD.TestField("Gen. Prod. Posting Group");
        ConferenceLineASD.TestField("Gen. Bus. Posting Group");
        ConferenceLineASD.TestField("VAT Prod. Posting Group");

        CheckPostingDate(ConferenceASD.PostingDate);
        CheckDocumentDate(ConferenceASD.DocumentDate);
        CheckQty(ConferenceLineASD.Quantity);
    end;

    local procedure CheckPostingDate(LocalPostingDate: Date)
    var
        PostingDateEmptyErr: Label 'Posting Date Field cannot be empty';
    begin
        if LocalPostingDate <> NormalDate(LocalPostingDate) then
            Error(PostingDateEmptyErr);
    end;

    local procedure CheckDocumentDate(LocalDocumentDate: Date)
    var
        PostingDateEmptyErr: Label 'Posting Date Field cannot be empty';
    begin
        if LocalDocumentDate <> NormalDate(LocalDocumentDate) then
            Error(PostingDateEmptyErr);
    end;

    local procedure CheckQty(LocalQty: Decimal)
    var
        QuantityNotLessZeroErr: Label 'Quantity cannot be less than 0';
        QuantityNotEqualZeroErr: Label 'Quantity cannot be equal to 0';
    begin
        if LocalQty < 0 then
            Error(QuantityNotLessZeroErr);
        if LocalQty = 0 then
            Error(QuantityNotEqualZeroErr);
    end;
}