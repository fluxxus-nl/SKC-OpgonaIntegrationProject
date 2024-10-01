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
        ItemJournalLine: Record "Item Journal Line";
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
        if not ConferenceLineASD.FindSet() then
            Error('There are no Conference lines to post for Conference %1.', ConferenceASD.DocumentNo)
        else begin
            repeat
                Code(ConferenceASD, ConferenceLineASD);
            until ConferenceLineASD.Next() = 0;

            PostConferenceLocationToJournal(ConferenceASD, ConferenceLineASD);
            ConferenceJnlCheckLineASD.DoCheckConferenceLocation(ConferenceLocationASD);
            PostConferenceLocationJournal();
        end;
    end;

    local procedure Code(ConferenceASD: Record "Conference ASD"; LocalConferenceLineASD: Record "Conference Line ASD")
    begin
        ConferenceJnlCheckLineASD.DoCheckConferenceDoc(ConferenceASD, LocalConferenceLineASD);
        PostConferenceDocToJournal(ConferenceASD, LocalConferenceLineASD);
        PostConferenceJournal();


        if LocalConferenceLineASD.type = LocalConferenceLineASD.type::Resource then begin
            PostResourceToJournal(ConferenceASD, LocalConferenceLineASD);
            PostResourceJournal();
        end;

        if LocalConferenceLineASD.type = LocalConferenceLineASD.type::Item then begin
            PostItemToJournal(ConferenceASD, LocalConferenceLineASD);
            PostItemJournal();
        end;
    end;

    local procedure PostConferenceDocToJournal(ConferenceASD: Record "Conference ASD"; LocalConferenceLineASD: Record "Conference Line ASD")
    begin
        ConferenceJournalASD.Description := LocalConferenceLineASD.Description;
        ConferenceJournalASD."Document Date" := ConferenceASD.DocumentDate;
        ConferenceJournalASD."Posting Date" := ConferenceASD.PostingDate;
        ConferenceJournalASD."Entry Type" := LocalConferenceLineASD.type;
        ConferenceJournalASD."Document No." := ConferenceASD.DocumentNo;
        ConferenceJournalASD.No := LocalConferenceLineASD."No.";
        ConferenceJournalASD.Description := LocalConferenceLineASD.Description;
        ConferenceJournalASD.Quantity := LocalConferenceLineASD.Quantity;
        ConferenceJournalASD."Unit of Measure Code" := LocalConferenceLineASD."Unit of Measure Code";
        ConferenceJournalASD."Unit Price" := LocalConferenceLineASD."Unit Price";
        ConferenceJournalASD."Total Price" := LocalConferenceLineASD.Amount;
        ConferenceJournalASD."Source Code" := ConferenceASD."Source Code";
        ConferenceJournalASD.NoAttendees := ConferenceASD.NoAttendees;
        ConferenceJournalASD."Line Discount" := ConferenceLineASD."Line Discount %";
        ConferenceJournalASD."Gen. Prod. Posting Group" := LocalConferenceLineASD."Gen. Prod. Posting Group";
        ConferenceJournalASD."VAT Prod. Posting Group" := LocalConferenceLineASD."VAT Prod. Posting Group";
        ConferenceJournalASD."Gen. Bus. Posting Group" := ConferenceASD."Gen. Bus. Posting Group";
        ConferenceJournalASD."VAT Bus. Posting Group" := ConferenceASD."VAT Bus. Posting Group";
    end;

    local procedure PostConferenceLocationToJournal(ConferenceASD: Record "Conference ASD"; LocalConferenceLineASD: Record "Conference Line ASD")
    begin
        ConferenceLocationASD.Get(ConferenceASD.ConferenceLocation);

        ConferenceJournalASD."Posting Date" := ConferenceASD.PostingDate;
        ConferenceJournalASD."Entry Type" := LocalConferenceLineASD.type::Location;
        ConferenceJournalASD."Document No." := ConferenceASD.DocumentNo;
        ConferenceJournalASD."Unit of Measure Code" := ConferenceLocationASD."Base Unit of Measure";
        ConferenceJournalASD.No := ConferenceLocationASD."No.";
        ConferenceJournalASD.Description := ConferenceLocationASD.Name;
        ConferenceJournalASD."Unit Price" := ConferenceLocationASD."Unit Price";
        ConferenceJournalASD."Gen. Prod. Posting Group" := ConferenceLocationASD."Gen. Prod. Posting Group";
        ConferenceJournalASD."VAT Prod. Posting Group" := ConferenceLocationASD."VAT Prod. Posting Group";
    end;

    local procedure PostResourceToJournal(ConferenceASD: Record "Conference ASD"; LocalConferenceLineASD: Record "Conference Line ASD")
    var
        Resource: Record Resource;
    begin
        Resource.Get(LocalConferenceLineASD."No.");
        ResJnlLine."Entry Type" := ResJnlLine."Entry Type"::Usage;
        ResJnlLine."Document No." := ConferenceASD.DocumentNo;
        ResJnlLine."Posting Date" := ConferenceASD.PostingDate;
        ResJnlLine.Description := LocalConferenceLineASD.Description;
        ResJnlLine."Gen. Prod. Posting Group" := LocalConferenceLineASD."Gen. Prod. Posting Group";
        ResJnlLine."Gen. Bus. Posting Group" := LocalConferenceLineASD."Gen. Bus. Posting Group";
        ResJnlLine."Source Code" := LocalConferenceLineASD."Source Code";
        ResJnlLine."Resource No." := Resource."No.";
        ResJnlLine."Unit Price" := Resource."Unit Price";
        ResjnlLine."Total Price" := LocalConferenceLineASD.Amount;
        ResJnlLine."Unit of Measure Code" := Resource."Base Unit of Measure";
        ResJnlLine."Unit Cost" := Resource."Unit Cost";
        ResJnlLine."Qty. per Unit of Measure" := 1;
        ResJnlLine."Document Date" := ConferenceASD.DocumentDate;
        ResJnlLine.Quantity := LocalConferenceLineASD.Quantity;
        ResJnlLine."Total Cost" := ResJnlLine."Unit Cost" * ResJnlLine.Quantity;
    end;

    local procedure PostItemToJournal(ConferenceASD: Record "Conference ASD"; LocalConferenceLineASD: Record "Conference Line ASD")
    var
        Item: Record Item;
    begin
        Item.Get(ConferenceLineASD."No.");
        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Sale;
        ItemJournalLine."Document Type" := ItemJournalLine."Document Type"::Conference;
        ItemJournalLine."Document No." := ConferenceASD.DocumentNo;
        ItemJournalLine."Item No." := Item."No.";
        ItemJournalLine."Posting Date" := ConferenceASD.PostingDate;
        ItemJournalLine.Description := LocalConferenceLineASD.Description;
        ItemJournalLine."Gen. Prod. Posting Group" := LocalConferenceLineASD."Gen. Prod. Posting Group";
        ItemJournalLine."Gen. Bus. Posting Group" := LocalConferenceLineASD."Gen. Bus. Posting Group";
        ItemJournalLine."Source Code" := LocalConferenceLineASD."Source Code";
        ItemJournalLine."Unit Cost (Calculated)" := Item."Unit Price";
        ItemJournalLine."Unit of Measure Code" := Item."Base Unit of Measure";
        ItemJournalLine."Unit Cost" := Item."Unit Cost";
        ItemJournalLine."Qty. per Unit of Measure" := 1;
        ItemJournalLine."Document Date" := ConferenceASD.DocumentDate;
        ItemJournalLine.Quantity := LocalConferenceLineASD.Quantity;
        ItemJournalLine."Quantity (Base)" := LocalConferenceLineASD.Quantity;
        ItemJournalLine."Item Shpt. Entry No." := 0;
    end;

    local procedure PostConferenceJournal()
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
        ConferenceLedgerEntryASD."User ID" := UserId();
        ConferenceLedgerEntryASD."Entry No." := NextEntryNo;
        ConferenceLedgerEntryASD.Insert();
        NextEntryNo := NextEntryNo + 1;
    end;

    local procedure PostConferenceLocationJournal()
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

    local procedure PostResourceJournal()
    var
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
    begin
        ResJnlPostLine.RunWithCheck(ResJnlLine);
    end;

    local procedure PostItemJournal()
    var
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
    begin
        ItemJnlPostLine.RunWithCheck(ItemJournalLine);
    end;
}