page 50004 "Conference List ASD"
{
    Caption = 'Conference';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Conference ASD";
    CardPageId = "Conference Card ASD";

    layout
    {
        area(Content)
        {
            repeater(Lists)
            {
                Caption = 'Lists';

                field(DocumentNo; Rec.DocumentNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(CustomerName; Rec.CustomerName)
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field(PostingDate; Rec.PostingDate)
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(ConferenceLocation; Rec.ConferenceLocation)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(NoAttendees; Rec.NoAttendees)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(StartingDate; Rec.StartingDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(StartingTime; Rec.StartingTime)
                {
                    ToolTip = 'Specifies the value of the Starting Time field.', Comment = '%';
                }
                field(EndingTime; Rec.EndingTime)
                {
                    ToolTip = 'Specifies the value of the Ending Time field.', Comment = '%';
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                }
                field("Total Price"; Rec."Total Price")
                {
                    ToolTip = 'Specifies the value of the Total Price field.', Comment = '%';
                }
            }
        }
    }
}