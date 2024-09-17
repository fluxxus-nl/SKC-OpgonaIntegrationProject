table 50005 "Conference Location ASD"
{
    DataClassification = CustomerContent;
    caption = 'Conference Location';

    fields
    {
        field(1; "No."; code[20])
        {
            Caption = 'No.';
        }

        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }

        field(5; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
        }
        field(8; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(9; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(10; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" where("Table Name" = const(conference), "No." = field("No.")));
        }
        field(11; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            trigger OnValidate();
            begin
                if xRec."Gen. Prod. Posting Group" <> Rec."Gen. Prod. Posting Group" then
                    if GenProdPostingGroup.ValidateVatProdPostingGroup(GenProdPostingGroup, Rec."Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGroup."Def. VAT Prod. Posting Group");
            end;
        }
        field(12; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; Status; enum "Status ASD")
        {
            caption = 'Status';
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }

    }
    keys
    {
        key(PK; "No.", "Address")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        ConferenceSetupASD: Record "Conference Setup ASD";
        NoSeriesManagement: codeunit NoSeriesManagement;
    begin
        if "No." = '' then
            if ConferenceSetupASD.Get() then begin
                ConferenceSetupASD.TestField(ConferenceLocationNos);
                NoSeriesManagement.InitSeries(ConferenceSetupASD.ConferenceLocationNos, Rec."No. Series", 0D, "No.", "No. Series");
            end;
    end;

    var
        GenProdPostingGroup: Record "Gen. Product Posting Group";
}