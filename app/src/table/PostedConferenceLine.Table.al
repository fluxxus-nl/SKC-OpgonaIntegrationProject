table 50009 "Posted Conference Line ASD"

{
    Caption = 'Posted Conference Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
        }
        field(4; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }
        field(5; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
        }
        field(6; Price; Decimal)
        {
            Caption = 'Price';
        }

        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; Registered; Boolean)
        {
            Caption = 'Registered';
        }
        field(9; type; enum "Journal Line Type ASD")
        {
            Caption = 'Type';
        }
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(11; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(12; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
        field(13; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
        }
        field(14; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(15; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';
        }
        field(16; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 2 Filter';
        }
        field(17; "Unit of Measure Code"; Code[20])
        {
            Caption = 'Unit of Measure Code';
        }
        field(18; "Discount Amount"; Decimal)
        {
            Caption = 'Discount % Amount';
        }
        field(19; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        field(20; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(21; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
        }
        field(22; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(23; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}