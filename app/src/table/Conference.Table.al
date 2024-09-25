table 50002 "Conference ASD"
{
    Caption = 'Conference Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; DocumentNo; Code[20])
        {
            Caption = 'No.';
            Tooltip = 'Specifies the value of the Document No. field';
        }
        field(2; Customer; Code[20])
        {
            Caption = 'Customer No.';
            Tooltip = 'Specifies the value of the Customer field';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                CustomernameASD: record Customer;
            begin
                if Customer <> '' then begin
                    CustomernameASD.Get(Customer);
                    CustomerName := CustomernameASD.Name;
                    "VAT Bus. Posting Group" := CustomernameASD."VAT Bus. Posting Group";
                    "Gen. Bus. Posting Group" := CustomernameASD."Gen. Bus. Posting Group"
                end
            end;
        }
        field(3; ConferenceLocation; Code[20])
        {
            Caption = 'Conference Location No.';
            Tooltip = 'Specifies the value of the Conference Location field';
            TableRelation = "Conference Location ASD"."No.";
            trigger OnValidate()
            var
                ConferenceLocationASD: record "Conference Location ASD";
            begin
                if ConferenceLocation <> '' then begin
                    ConferenceLocationASD.Get(ConferenceLocation);
                    "Unit Price" := ConferenceLocationASD."Unit Price";
                end;

            end;
        }
        field(4; StartingDate; Date)
        {
            Caption = 'Conference Date';
            Tooltip = 'Specifies the value of the Starting Date field';
        }
        field(5; EndingDate; Date)
        {
            Caption = 'Ending Date';
            Tooltip = 'Specifies the value of the Ending Date field';
        }
        field(6; StartingTime; Time)
        {
            Caption = 'Starting Time';
            Tooltip = 'Specifies the value of the Starting Time field';
        }
        field(7; EndingTime; Time)
        {
            Caption = 'Ending Time';
            Tooltip = 'Specifies the value of the Ending Time field';
        }
        field(8; DocumentDate; Date)
        {
            Caption = 'Document Date';
            Tooltip = 'Specifies the value of the Document Date field';
        }
        field(9; PostingDate; Date)
        {
            Caption = 'Posting Date';
            Tooltip = 'Specifies the value of the Posting Date field';
        }
        field(10; NoAttendees; Integer)
        {
            Caption = 'No. of Attendees';
            Tooltip = 'Specifies the value of the No. of Attendees field';
        }
        field(11; Status; Enum "Status ASD")
        {
            Caption = 'Status';
            Tooltip = 'Specifies the value of the Status field';
        }
        field(12; DocumentNoSeries; Code[20])
        {
            Caption = 'Document No Series';
            Tooltip = 'Specifies the value of the DocumentNoSeries field';
        }
        field(13; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(14; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(16; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = CustomerContent;
            TableRelation = "Source Code";
        }
        field(17; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 0;
        }
        field(18; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
        }
        field(19; "Duration"; Duration)
        {
            Caption = 'Duration';

            trigger OnValidate();
            begin
                EndingTime := StartingTime + Duration;
                "Total Price" := "Unit Price" * Duration / 3600000;
            end;
        }
        field(20; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(21; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(22; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(23; CustomerName; Code[50])
        {
            Caption = 'Customer Name';
        }
    }

    keys
    {
        key(Key1; DocumentNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ConferenceLocation)
        {
        }
    }

    trigger OnInsert()
    var
        ConferenceSetupASD: Record "Conference Setup ASD";
        NoSeriesManagement: codeunit NoSeriesManagement;
    begin
        if DocumentNo = '' then
            if ConferenceSetupASD.Get() then begin
                ConferenceSetupASD.TestField(ConferenceRegNos);
                NoSeriesManagement.InitSeries(ConferenceSetupASD.ConferenceRegNos, Rec.DocumentNoSeries, 0D, DocumentNo, DocumentNoSeries);
                InitRecord();
            end;
    end;

    procedure InitRecord();
    begin
        if Rec."PostingDate" = 0D then
            Rec."PostingDate" := WorkDate();
        Rec."DocumentDate" := WorkDate();
    end;

    procedure ValidateTimeOrder()
    begin
        if "StartingTime" > "EndingTime" then
            Error('Ending Time cannot be earlier than Starting Time.');
    end;

    procedure TestStatusOpen()
    begin
        TestField(Status, Status::Closed);
    end;
}