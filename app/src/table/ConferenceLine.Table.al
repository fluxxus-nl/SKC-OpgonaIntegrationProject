table 50003 "ConferenceLine ASD"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Conference ASD";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(4; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            Editable = false;
        }
        field(5; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            InitValue = true;
        }
        field(6; Price; Decimal)
        {
            Caption = 'Price';
            AutoFormatType = 2;
        }

        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            AutoFormatType = 1;
        }
        field(8; Registered; Boolean)
        {
            Caption = 'Registered';
            Editable = false;
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
