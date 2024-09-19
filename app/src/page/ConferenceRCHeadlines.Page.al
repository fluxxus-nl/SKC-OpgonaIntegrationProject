page 50018 "Conference RC Headlines ASD"
{
    Caption = 'Headline';
    PageType = HeadlinePart;
    ApplicationArea = All;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(GreetingHeadLine)
            {
                ShowCaption = false;
                Visible = UserGreetingVisible;

                field("Greeting Text"; RCHeadlinesPageCommon.GetGreetingText())
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Documentation Text"; RCHeadlinesPageCommon.GetDocumentationText())
                {
                    Editable = false;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        HyperLink(RCHeadlinesPageCommon.DocumentationUrlTxt());
                    end;
                }
            }
            group(DocumentationHeadline)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        DefaultfieldsVisible: Boolean;
        UserGreetingVisible: boolean;
        RCHeadlinesPageCommon: codeunit "RC Headlines Page Common";

    trigger OnOpenPage()
    var
    begin
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Conference RC Headlines ASD");
        DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
        UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();
    end;
}