table 50002 "Conference ASD"
{
    Caption = 'Conference Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; DocumentNo; Code[20])
        {
            Caption = 'Document No.';
            Tooltip = 'Specifies the value of the Document No. field';
        }
        field(2; Customer; Code[20])
        {
            Caption = 'Customer';
            Tooltip = 'Specifies the value of the Customer field';
            TableRelation = Customer."No.";
        }
        field(3; ConferenceLocation; Code[20])
        {
            Caption = 'Conference Location';
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
            Caption = 'Starting Date';
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
            end;
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