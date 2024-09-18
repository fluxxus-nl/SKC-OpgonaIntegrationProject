table 50006 "Conference Journal ASD"
{
    Caption = 'Conference Journal';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Res. Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Entry Type"; Enum "Journal Line Type ASD")
        {
            Caption = 'Entry Type';
            trigger onValidate()
            begin
                if rec."Entry Type" <> xrec."Entry Type" then begin
                    rec."Document No." := '';
                    rec.Quantity := 0;
                    rec."Unit Cost" := 0;
                    rec."Unit of Measure Code" := '';
                    rec."Total Cost" := 0;
                    rec."Unit Price" := 0;
                    rec."Total Price" := 0;
                    rec.Description := '';
                end
            end;
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                TestField("Posting Date");
                Validate("Document Date", "Posting Date");
            end;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Resource Unit of Measure";
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Validate("Unit Cost");
                Validate("Unit Price");
            end;
        }
        field(9; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            MinValue = 0;

            trigger OnValidate()
            begin
                "Total Cost" := Quantity * "Unit Cost";
            end;
        }
        field(10; "Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Cost';

            trigger OnValidate()
            begin
                TestField(Quantity);
                GetGLSetup();
                "Unit Cost" := Round("Total Cost" / Quantity, GLSetup."Unit-Amount Rounding Precision");
            end;
        }
        field(11; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin
                "Total Price" := Quantity * "Unit Price";
            end;
        }
        field(12; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';

            trigger OnValidate()
            begin
                TestField(Quantity);
                GetGLSetup();
                "Unit Price" := Round("Total Price" / Quantity, GLSetup."Unit-Amount Rounding Precision");
            end;
        }
        field(13; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(14; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Res. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(15; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(16; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(18; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(19; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(20; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }

        field(21; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(22; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(23; No; Code[20])
        {
            Caption = 'No.';
            TableRelation = if ("Entry Type" = const(Location)) "Conference Location ASD"
            else
            if ("Entry Type" = const("Item")) Item
            else
            if ("Entry Type" = const(Resource)) Resource;

            trigger OnValidate()
            var
                Item: Record Item;
                resource: record Resource;
                location: Record "Conference Location ASD";
            begin
                case Rec."Entry Type" of
                    Rec."Entry Type"::Item:
                        begin
                            Item.Get(Rec.No);
                            rec.Description := Item.Description;
                            rec."Unit Price" := Item."Unit Price";
                        end;
                    Rec."Entry Type"::Resource:
                        begin
                            Resource.Get(Rec.No);
                            rec.Description := Resource.Name;
                            rec."Unit Price" := Resource."Unit Price";
                        end;
                    Rec."Entry Type"::Location:
                        begin
                            location.Get(Rec.No);
                            rec.Description := location.Name;
                            rec."Unit Price" := location."Unit Price";
                        end;
                end;
            end;
        }
        field(24; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(25; "Line Discount"; decimal)
        {
            Caption = 'Line Discount';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Posting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        GLSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GLSetup.Get();
        GLSetupRead := true;
    end;

    internal procedure CheckEmptyLine(): Boolean
    begin
        exit(Rec."Document No." = '');
    end;
}