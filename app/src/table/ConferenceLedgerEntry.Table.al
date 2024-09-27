table 50010 "Conference Ledger Entry ASD"
{
    Caption = 'Conference Ledger Entry';
    DrillDownPageID = "Conference Ledger Entries ASD";
    LookupPageID = "Conference Ledger Entries ASD";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Entry Type"; Enum "Journal Line Type ASD")
        {
            Caption = 'Entry Type';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Resource No."; Code[20])
        {
            Caption = 'No.';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
        }
        field(15; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(16; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
        }
        field(21; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(23; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(24; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(25; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(26; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(27; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(29; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(30; Quantity; decimal)
        {
            Caption = 'Quantity';
        }
        field(31; "VAT. Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
    }

    keys
    {
        key(PK1; "Entry No.", "Document No.", Description, "Posting Date")
        {
            Clustered = true;
        }
    }

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;

    procedure CopyFromConferenceJnlLine(ConferenceJournalASD: Record "Conference Journal ASD");
    begin
        Rec."Entry Type" := ConferenceJournalASD."Entry Type";
        Rec."Document No." := ConferenceJournalASD."Document No.";
        Rec."Posting Date" := ConferenceJournalASD."Posting Date";
        Rec."Document Date" := ConferenceJournalASD."Document Date";
        Rec."Resource No." := ConferenceJournalASD.No;
        Rec.Description := ConferenceJournalASD.Description;
        Rec.Quantity := ConferenceJournalASD.Quantity;
        Rec."Unit Price" := ConferenceJournalASD."Unit Price";
        Rec."Total Price" := ConferenceJournalASD."Total Price";
        //Rec."Starting Date" := ConferenceJournalASD."Starting Date";
        //Rec."Resource Ledger Entry No." := ConferenceJournalASD."Resource Ledger Entry No.";
        Rec."Source Code" := ConferenceJournalASD."Source Code";
        Rec."Journal Batch Name" := ConferenceJournalASD."Journal Batch Name";
        Rec."Reason Code" := ConferenceJournalASD."Reason Code";
        //Rec."Global Dimension 1 Code" := ConferenceJournalASD."Shortcut Dimension 1 Code";
        //Rec."Global Dimension 2 Code" := ConferenceJournalASD."Shortcut Dimension 2 Code";
        //Rec."Dimension Set ID" := ConferenceJournalASD."Dimension Set ID";
    end;
}