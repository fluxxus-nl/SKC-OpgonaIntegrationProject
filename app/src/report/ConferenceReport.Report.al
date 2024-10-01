report 50000 "Conference Report ASD"
{
    Caption = 'Conference Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = './Layouts/Conference.docx';
    dataset
    {
        dataitem(ConferenceHeader; "Posted Conference Header ASD")
        {
            DataItemTableView = sorting(DocumentNo);
            RequestFilterFields = DocumentNo, ConferenceLocation;

            column(Conference_no; "Documentno") { IncludeCaption = true; }
            column(Customer_no; Customer) { IncludeCaption = true; }
            column(Conference_Location; "ConferenceLocation") { IncludeCaption = true; }
            column(GlobalConfLocLbl; GlobalConfLocLbl) { }
            column(Conference_Name; GlobalConferenceName) { }
            column(NoAttendees; NoAttendees) { IncludeCaption = true; }
            column(CompanyInfo_Picture; CompanyInformation.Picture) { IncludeCaption = true; }
            column(CompanyInfo_Name; CompanyInformation.Name) { IncludeCaption = true; }
            column(CompanyInfo_Address; CompanyInformation.Address) { IncludeCaption = true; }
            column(CompanyInfo_City; CompanyInformation.City) { IncludeCaption = true; }

            dataitem("Conference Line Line ASD"; "Posted Conference Line ASD")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLinkReference = ConferenceHeader;
                DataItemLink = "Document No." = field(DocumentNo);

                column(type; type) { IncludeCaption = true; }
                column(Document_No_; "Document No.") { IncludeCaption = true; }
                column(No_; "No.") { IncludeCaption = true; }
                column(Description; Description) { IncludeCaption = true; }
                column(Quantity; "Quantity") { IncludeCaption = true; }
                column(Amount; Amount) { IncludeCaption = true; }
            }
            trigger OnAfterGetRecord()
            begin
                ConferenceLocationASD.Get(ConferenceHeader.ConferenceLocation);
                GlobalConferenceName := ConferenceLocationASD.Name;
            end;
        }
    }

    labels
    {
        Conference = 'Conference ASD Registration -Participant List';
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        ConferenceLocationASD: Record "Conference Location ASD";
        CompanyInformation: Record "Company Information";
        GlobalConferenceName: Text[100];
        GlobalConfLocLbl: Label 'Location Name';
}