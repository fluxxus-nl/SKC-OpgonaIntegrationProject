codeunit 50000 "Conference Jnl.-Check Line ASD"
{
    TableNo = "Conference Journal ASD";

    trigger OnRun()
    begin
        DoCheck(Rec); // Do the checks here
    end;

    internal procedure DoCheck(LocalConferenceJournal: Record "Conference Journal ASD")
    begin
        LocalConferenceJournal.TestField("Document No.");
        LocalConferenceJournal.TestField("Posting Date");
        LocalConferenceJournal.TestField("Document Date");
        LocalConferenceJournal.TestField("Document Date");
        LocalConferenceJournal.TestField("Gen. Prod. Posting Group");
        LocalConferenceJournal.TestField("Gen. Bus. Posting Group");

        CheckPostingDate(LocalConferenceJournal."Posting Date");
        CheckDocumentDate(LocalConferenceJournal."Document Date");
        CheckQty(LocalConferenceJournal.Quantity);
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