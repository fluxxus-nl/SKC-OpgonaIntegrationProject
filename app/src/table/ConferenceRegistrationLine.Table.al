table 50003 "ConferenceRegistrationLine ASD"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = "Conferenceregheader ASD";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(4; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(6; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
            AutoFormatType = 2;
        }

        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(8; Registered; Boolean)
        {
            Caption = 'Registered';
            DataClassification = CustomerContent;
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
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateUnitPrice(var SalesLine: Record "ConferenceRegistrationLine ASD"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
    end;

}
