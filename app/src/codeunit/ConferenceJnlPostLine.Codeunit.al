codeunit 50001 "Conference Jnl.-Post Line ASD"
{
    TableNo = "Conference ASD";

    var
        ConferenceJournalASD: Record "Conference Journal ASD";
        ConferenceLineASD: Record "Conference Line ASD";
        ConferenceLocationASD: Record "Conference Location ASD";
        ConferenceRegister: Record "Conference Register ASD";
        ResourceRegister: Record "Resource Register";
        ResJnlLine: Record "Res. Journal Line";
        ResourceLedgerEntry: Record "Res. Ledger Entry";
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
        ConferenceJnlCheckLineASD.DoCheckConferenceDoc(ConferenceASD, ConferenceLineASD);
        PostConferenceDocToJournal(ConferenceASD, ConferenceLineASD);
        PostConferenceJournal(ConferenceJournalASD);

        PostConferenceLocationToJournal(ConferenceASD, ConferenceLineASD);
        ConferenceJnlCheckLineASD.DoCheckConferenceLocation(ConferenceLocationASD);
        PostConferenceLocationJournal(ConferenceJournalASD);

        if ConferenceLineASD.type = ConferenceLineASD.type::Resource then begin
            PostResourceToJournal(ConferenceASD, ConferenceLineASD);
            PostResourceJournal(ResJnlLine);
        end;
    end;

    local procedure PostConferenceDocToJournal(ConferenceASD: Record "Conference ASD"; ConferenceLineASD: Record "Conference Line ASD")
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
        ConferenceJournalASD."Source Code" := ConferenceASD."Source Code";
        ConferenceJournalASD."Line Discount" := ConferenceLineASD."Line Discount %";
        ConferenceJournalASD."Gen. Prod. Posting Group" := ConferenceLineASD."Gen. Prod. Posting Group";
        ConferenceJournalASD."Gen. Bus. Posting Group" := ConferenceLineASD."Gen. Bus. Posting Group";
        ConferenceJournalASD."VAT Prod. Posting Group" := ConferenceLineASD."VAT Prod. Posting Group";
    end;

    local procedure PostConferenceLocationToJournal(ConferenceASD: Record "Conference ASD"; ConferenceLineASD: Record "Conference Line ASD")
    begin
        ConferenceLocationASD.Get(ConferenceASD.ConferenceLocation);

        ConferenceJournalASD."Posting Date" := ConferenceASD.PostingDate;
        ConferenceJournalASD."Entry Type" := ConferenceLineASD.type::Location;
        ConferenceJournalASD."Document No." := ConferenceASD.DocumentNo;
        ConferenceJournalASD."Unit of Measure Code" := ConferenceLocationASD."Base Unit of Measure";
        ConferenceJournalASD.No := ConferenceLocationASD."No.";
        ConferenceJournalASD.Description := ConferenceLocationASD.Name;
        ConferenceJournalASD."Unit Price" := ConferenceLocationASD."Unit Price";
        ConferenceJournalASD."Gen. Prod. Posting Group" := ConferenceLocationASD."Gen. Prod. Posting Group";
        ConferenceJournalASD."VAT Prod. Posting Group" := ConferenceLocationASD."VAT Prod. Posting Group";
    end;

    local procedure PostResourceToJournal(ConferenceASD: Record "Conference ASD"; ConferenceLineASD: Record "Conference Line ASD")
    var
        Resource: Record Resource;
    begin
        Resource.Get(ConferenceLineASD."No.");
        ResJnlLine."Entry Type" := ResJnlLine."Entry Type"::Usage;
        ResJnlLine."Document No." := ConferenceASD.DocumentNo;
        ResJnlLine."Resource No." := Resource."No.";
        ResJnlLine."Posting Date" := ConferenceASD.PostingDate;
        //ResJnlLine."Reason Code" := ConferenceLineASD.re;
        ResJnlLine.Description := ConferenceLineASD.Description;
        ResJnlLine."Gen. Prod. Posting Group" := ConferenceLineASD."Gen. Prod. Posting Group";
        ResJnlLine."Gen. Bus. Posting Group" := ConferenceLineASD."Gen. Bus. Posting Group";
        ResJnlLine."Source Code" := ConferenceLineASD."Source Code";
        ResJnlLine."Resource No." := Resource."No.";
        ResJnlLine."Unit of Measure Code" := Resource."Base Unit of Measure";
        ResJnlLine."Unit Cost" := Resource."Unit Cost";
        ResJnlLine."Qty. per Unit of Measure" := 1;
        ResJnlLine."Document Date" := ConferenceASD.DocumentDate;
        //ResJnlLine."Posting No. Series" := ;
        ResJnlLine.Quantity := ConferenceLineASD.Quantity;
        ResJnlLine."Total Cost" := ResJnlLine."Unit Cost" * ResJnlLine.Quantity;
        //ResJnlLine."Shortcut Dimension 1 Code" := ResJnlLine."Shortcut Dimension 1 Code";
        //ResJnlLine."Shortcut Dimension 2 Code" := ResJnlLine."Shortcut Dimension 2 Code";
        //ResJnlLine."Dimension Set ID" := ResJnlLine."Dimension Set ID";
    end;

    local procedure PostConferenceJournal(ConferenceJournalASD: Record "Conference Journal ASD")
    var
        ConferenceLedgerEntryASD: Record "Conference Ledger Entry ASD";
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

        ConferenceLedgerEntryASD.Init();
        ConferenceLedgerEntryASD.CopyFromConferenceJnlLine(ConferenceJournalASD);

        ConferenceLedgerEntryASD."Total Price" := Round(ConferenceLedgerEntryASD."Total Price");
        ConferenceLedgerEntryASD.Description := '';
        ConferenceLedgerEntryASD."User ID" := UserId();
        ConferenceLedgerEntryASD."Entry No." := NextEntryNo;
        ConferenceLedgerEntryASD.Insert();
        NextEntryNo := NextEntryNo + 1;
    end;

    local procedure PostConferenceLocationJournal(ConferenceJournalASD: Record "Conference Journal ASD")
    var
        ConferenceLedgerEntryASD: Record "Conference Ledger Entry ASD";
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

        ConferenceLedgerEntryASD.Init();
        ConferenceLedgerEntryASD.CopyFromConferenceJnlLine(ConferenceJournalASD);

        ConferenceLedgerEntryASD."Total Price" := Round(ConferenceLedgerEntryASD."Total Price");
        ConferenceLedgerEntryASD.Description := '';
        ConferenceLedgerEntryASD."User ID" := UserId();
        ConferenceLedgerEntryASD."Entry No." := NextEntryNo;
        ConferenceLedgerEntryASD.Insert();
        NextEntryNo := NextEntryNo + 1;
    end;

    local procedure PostResourceJournal(ResourceJournalASD: Record "Res. Journal Line")
    var
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
    begin
        ResJnlPostLine.RunWithCheck(ResJnlLine);
    end;
}