codeunit 50001 "Conference Jnl.-Post Line ASD"
{
    TableNo = "Conference ASD";

    var
        ConferenceJournalASD: Record "Conference Journal ASD";
        ConferenceLineASD: Record "Conference Line ASD";
        ConferenceRegister: Record "Conference Register ASD";

        ConferenceJnlCheckLineASD: Codeunit "Conference Jnl.-Check Line ASD";
        NextEntryNo: Integer;


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
        ConferenceASD: Record "Conference ASD";

    begin
        if NextEntryNo = 0 then begin
            ConferenceLedgerEntryASD.LockTable();
            NextEntryNo := ConferenceLedgerEntryASD.GetLastEntryNo() + 1;
        end;

        if ConferenceRegister."No." = 0 then begin
            ConferenceRegister.LockTable();
            if (not ConferenceRegister.FindLast()) or (ConferenceRegister."To Entry No." <> 0) then begin
                ConferenceRegister.Init();
                ConferenceRegister."No." := ConferenceRegister."No." + 1;
                ConferenceRegister."From Entry No." := NextEntryNo;
                ConferenceRegister."To Entry No." := NextEntryNo;
                ConferenceRegister."Creation Date" := Today();
                ConferenceRegister."Creation Time" := Time();
                ConferenceRegister."Source Code" := ConferenceJournalASD."Source Code";
                ConferenceRegister."Journal Batch Name" := ConferenceJournalASD."Journal Batch Name";
                ConferenceRegister."User ID" := UserId();
                ConferenceRegister.Insert();
            end;
        end;
        ConferenceRegister."To Entry No." := NextEntryNo;
        ConferenceRegister.Modify();

        ConferenceASD.Get(ConferenceJournalASD."Document No.");
        //ConferenceASD.TestField(Blocked, false);

        ConferenceLedgerEntryASD.Init();
        ConferenceLedgerEntryASD.CopyFromConferenceJnlLine(ConferenceJournalASD);

        ConferenceLedgerEntryASD."Total Price" := Round(ConferenceLedgerEntryASD."Total Price");
        ConferenceLedgerEntryASD.Description := '';
        ConferenceLedgerEntryASD."User ID" := UserId();
        ConferenceLedgerEntryASD."Entry No." := NextEntryNo;
        ConferenceLedgerEntryASD.Insert();
        NextEntryNo := NextEntryNo + 1;
    end;
}