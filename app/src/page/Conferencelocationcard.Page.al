page 50002 "Conference Location Card ASD"
{
    Caption = 'Conference Location';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Conference Location ASD";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.', Comment = '%';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.', Comment = '%';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.', Comment = '%';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }

            }
            group("Invoicing Details")
            {
                Caption = 'Invoice Details';

                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Base Unit of Measure field.', Comment = '%';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.', Comment = '%';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.', Comment = '%';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {
            systempart(Links; Links) { }
            systempart(Notes; Notes) { }
        }
    }

    actions
    {

        area(Processing)
        {
            action(CreateConferenceDocument)
            {
                Caption = 'Create Conference Document';
                ToolTip = 'Specifies the Create Conference Document action';
                ApplicationArea = All;
                Scope = Repeater;
                Image = Create;

                trigger OnAction();
                var
                    ConferenceASD: record "Conference ASD";
                begin
                    if Rec."No." <> '' then begin
                        ConferenceASD.Init();
                        ConferenceASD.ConferenceLocation := Rec."No.";
                        if Rec."Unit Price" <> 0 then
                            ConferenceASD."Unit Price" := Rec."Unit Price";
                        ConferenceASD.Insert(true);
                        PAGE.Run(Page::"Conference Card ASD", ConferenceASD);
                    end;
                end;
            }
        }
        area(Navigation)
        {
            action(Dimensions)
            {
                Caption = 'Dimensions';
                ToolTip = 'Specifies the Dimensions of this Location';
                ApplicationArea = All;
                Image = Dimensions;
                ShortcutKey = 'Shift+Ctrl+D';
                RunObject = page "Default Dimensions";
            }
        }
    }
}