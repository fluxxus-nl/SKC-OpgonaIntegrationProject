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
        field(9; type; enum "Journal Line Type ASD")
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
                Resource: Record Resource;
                ResourceIsBlockedErr: Label 'You cannot create this type of document when %1 is blocked', Comment = '%1=Resource No';
                ItemIsBlockedErr: Label 'You cannot create this type of document when %1 is blocked', Comment = '%1=Item No';
            begin
                if Rec."No." <> xrec."No." then begin
                    Rec."Unit of Measure Code" := '';
                    Rec.Quantity := 0;
                    Rec."Unit Price" := 0;
                    Rec.Amount := 0;
                    Rec."Line Discount %" := 0;
                    Rec."Discount Amount" := 0;
                end;
                case Rec.Type of
                    Rec.Type::Item:
                        begin
                            Item.Get(Rec."No.");

                            if Item.Blocked then
                                Error(ItemIsBlockedErr, Item."No.");

                            rec.Description := Item.Description;
                            rec."Unit Price" := Item."Unit Price";
                            rec."Unit of Measure Code" := item."Base Unit of Measure";
                            rec."Gen. Prod. Posting Group" := item."Gen. Prod. Posting Group";
                            rec."VAT Prod. Posting Group" := item."VAT Prod. Posting Group";
                        end;
                    Rec.Type::Resource:
                        begin
                            Resource.Get(Rec."No.");

                            if Resource.Blocked then
                                Error(ResourceIsBlockedErr, Resource."No.");

                            rec.Description := Resource.Name;
                            rec."Unit Price" := Resource."Unit Price";
                            rec."Unit of Measure Code" := Resource."Base Unit of Measure";
                            rec."Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                            rec."VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                        end;
                end;
            end;
        }
        field(11; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                Validate("Line Discount %");
            end;
        }
        field(12; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            InitValue = 1;
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
        field(17; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
        }
        field(18; "Discount Amount"; Decimal)
        {
            Caption = 'Line Discount % Amount';
        }
        field(19; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(20; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(21; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(22; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(23; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Source Code";
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure RecalculateAmounts()
    begin
        "Amount" := "Unit Price" * "Quantity";
        "Discount Amount" := ("Amount" * "Line Discount %") / 100;
        "Amount" := "Amount" - "Discount Amount";
    end;
}
