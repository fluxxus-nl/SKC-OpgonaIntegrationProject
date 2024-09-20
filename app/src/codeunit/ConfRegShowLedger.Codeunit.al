codeunit 50006 "Conf. Reg.-Show Ledger ASD"
{
    TableNo = "Conference Register ASD";

    trigger OnRun()
    begin
        ConfLedgEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        PAGE.Run(PAGE::"Conference Ledger Entries ASD", ConfLedgEntry);
    end;

    var
        ConfLedgEntry: Record "Conference Ledger Entry ASD";
}

