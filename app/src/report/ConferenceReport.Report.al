report 50000 "Conference Report ASD"
{
    Caption = 'Conference Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = './Layouts/Conference.docx';
    dataset
    {
        dataitem(ConferenceHeader; "Conference ASD")
        {
            DataItemTableView = sorting(DocumentNo);
            RequestFilterFields = DocumentNo, ConferenceLocation;
            column(Conference_no; "Documentno") { IncludeCaption = true; }
            column(Conference_Location; "ConferenceLocation") { IncludeCaption = true; }
            column(Starting_Date; "StartingDate") { IncludeCaption = true; }
            column(StartingTime; StartingTime) { IncludeCaption = true; }
            column("Duration"; Duration) { IncludeCaption = true; }
            column(EndingTime; EndingTime) { IncludeCaption = true; }
            column(NoAttendees; NoAttendees) { IncludeCaption = true; }
            dataitem("Conference Line Line ASD"; "Conference Line ASD")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLink = "Document No." = field(DocumentNo);
                column(type; type) { IncludeCaption = true; }
                column(Document_No_; "Document No.") { IncludeCaption = true; }
                column(No_; "No.") { IncludeCaption = true; }
                column(Description; Description) { IncludeCaption = true; }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { IncludeCaption = true; }
                column(Unit_Price; "Unit Price") { IncludeCaption = true; }
                column(Amount; Amount) { IncludeCaption = true; }

            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            column(CompanyInformation_Name; CompanyInformation.Name) { }
        }
    }
    labels
    {
        Conference = 'Conference ASD Registration -Participant List';
    }
    var
        CompanyInformation: Record "Company Information";
        print: Boolean;
}