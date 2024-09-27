codeunit 50000 "Conference Jnl.-Check Line ASD"
{
    TableNo = "Conference ASD";
    internal procedure DoCheckConferenceDoc(ConferenceASD: Record "Conference ASD"; ConferenceLineASD: Record "Conference Line ASD")
    begin
        ConferenceASD.TestField(Customer);
        ConferenceASD.TestField(ConferenceLocation);
        ConferenceASD.TestField(DocumentDate);
        ConferenceASD.TestField(PostingDate);
        CheckPostingDate(ConferenceASD.PostingDate);
        CheckDocumentDate(ConferenceASD.DocumentDate);
        case ConferenceLineASD.type of
            ConferenceLineASD.type::Item:
                ConferenceLineASD.TestField("No.");
            ConferenceLineASD.type::Resource:
                ConferenceLineASD.TestField("No.");
        end;
        ConferenceLineASD.TestField("No.");
        ConferenceLineASD.TestField("Unit of Measure Code");
        ConferenceLineASD.TestField(Quantity);
        ConferenceLineASD.TestField("Unit Price");
        ConferenceLineASD.TestField(Amount);

        if ConferenceASD."Gen. Bus. Posting Group" <> '' then
            ConferenceLineASD."Gen. Bus. Posting Group" := ConferenceASD."Gen. Bus. Posting Group";

        ConferenceLineASD.TestField("Gen. Bus. Posting Group");
        ConferenceLineASD.TestField("Gen. Prod. Posting Group");
        ConferenceLineASD.TestField("VAT Prod. Posting Group");

        CheckQty(ConferenceLineASD.Quantity);

        ConferenceASD.TestField(StartingDate);
        ConferenceASD.TestField(StartingTime);
        ConferenceASD.TestField(Duration);
        ConferenceASD.TestField(NoAttendees);
    end;

    internal procedure DoCheckConferenceLocation(ConferenceLocationASD: Record "Conference Location ASD")
    begin
        ConferenceLocationASD.TestField("No.");
        ConferenceLocationASD.TestField("Base Unit of Measure");
        ConferenceLocationASD.TestField("Unit Price");
        ConferenceLocationASD.TestField("Gen. Prod. Posting Group");
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