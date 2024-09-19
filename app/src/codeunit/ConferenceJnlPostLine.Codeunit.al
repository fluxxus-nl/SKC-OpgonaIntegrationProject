codeunit 50001 "Conference Jnl.-Post Line ASD"
{
    TableNo = "Conference ASD";

    var
        ConferenceJournalASD: Record "Conference Journal ASD";
        ConferenceLineASD: Record "Conference Line ASD";
        ConferenceJnlCheckLineASD: Codeunit "Conference Jnl.-Check Line ASD";

    trigger OnRun()
    begin
        GetConferenceLines(Rec);
    end;

    procedure GetConferenceLines(ConferenceASD: Record "Conference ASD")
    begin
        ConferenceLineASD.Reset();
        ConferenceLineASD.SetRange("Document No.", ConferenceASD.DocumentNo);
        if ConferenceLineASD.FindSet() then
            repeat
                Code(ConferenceASD, ConferenceLineASD);
            until ConferenceLineASD.Next() = 0;
    end;

    local procedure Code(ConferenceASD: Record "Conference ASD"; ConferenceLineASD: Record "Conference Line ASD")
    begin
        PostDocumentToJournal(ConferenceASD, ConferenceLineASD);
        ConferenceJnlCheckLineASD.DoCheck(ConferenceASD, ConferenceLineASD);
        PostJournalToLedger(ConferenceJournalASD);
    end;

    local procedure PostDocumentToJournal(ConferenceASD: Record "Conference ASD"; ConferenceLineASD: Record "Conference Line ASD")
    begin
        ConferenceJournalASD."Posting Date" := ConferenceASD.PostingDate;
        ConferenceJournalASD."Entry Type" := ConferenceLineASD.type;
        ConferenceJournalASD."Document No." := ConferenceASD.DocumentNo;
        ConferenceJournalASD.No := ConferenceLineASD."No.";
        ConferenceJournalASD.Description := ConferenceLineASD.Description;
        ConferenceJournalASD.Quantity := ConferenceLineASD.Quantity;
        ConferenceJournalASD."Unit of Measure Code" := ConferenceLineASD."Unit of Measure Code";
        ConferenceJournalASD."Unit Price" := ConferenceLineASD."Unit Price";
        ConferenceJournalASD."Total Price" := ConferenceLineASD.Amount;
        ConferenceJournalASD."Line Discount" := ConferenceLineASD."Line Discount %";
        ConferenceJournalASD."Gen. Prod. Posting Group" := ConferenceLineASD."Gen. Prod. Posting Group";
        ConferenceJournalASD."Gen. Bus. Posting Group" := ConferenceLineASD."Gen. Bus. Posting Group";
        ConferenceJournalASD."VAT Prod. Posting Group" := ConferenceLineASD."VAT Prod. Posting Group";
    end;

    local procedure PostJournalToLedger(ConferenceJournalASD: Record "Conference Journal ASD")
    var
        ConferenceLedgerEntryASD: Record "Conference Ledger Entry ASD";
    begin
    end;
}