table 50003 "Conference Line ASD"
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
        field(9; type; enum "Sales Line Type ASD")
        {
            Caption = 'Type';
            Dataclassification = CustomerContent;
            trigger onValidate()
            begin
                if rec."Type" <> xrec."Type" then begin
                    rec."No." := '';
                    rec."Bill-to Customer No." := '';
                    rec.Amount := 0;
                    rec.Price := 0;
                end
            end;
        }
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const("Item")) Item;
            trigger onvalidate()
            var
                Item: Record Item;
            begin
                Item.Get(Rec."No.");
                rec.Description := Item.Description;
                rec."Unit Price" := Item."Unit Price";
            end;
        }
        field(11; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateUnitPrice(Rec, CurrFieldNo, IsHandled);
                if not IsHandled then
                    Validate("Line Discount %");
            end;
        }
        field(12; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(13; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(14; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(15; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(16; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateUnitPrice(var SalesLine: Record "Conference Line ASD"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
    end;

}
