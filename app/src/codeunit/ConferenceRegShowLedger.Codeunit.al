codeunit 50004 "Conference. Reg.-Show Ledger"
{
    TableNo = "Conference Register ASD";

    trigger OnRun()
    begin
        ResLedgEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        PAGE.Run(PAGE::"Conference Ledger Entries ASD", ResLedgEntry);
    end;

    var
        ResLedgEntry: Record "Conference Ledger Entry ASD";
}