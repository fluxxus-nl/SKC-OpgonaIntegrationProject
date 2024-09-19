page 50019 "Conference Manager RC ASD"
{
    Caption = 'Conference Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(ConferenceRCHeadlines; "Conference RC Headlines ASD")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ConferenceManagerActivities; "Conference Activities ASD")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ReportInboxPart; "Report Inbox Part")
            {
                ApplicationArea = Suite;
                AccessByPermission = tabledata "Report Inbox" = R;
            }
            part(MyJobQueue; "My Job Queue")
            {
                ApplicationArea = Advanced;
            }
            part(MyConferences; "My Conference List ASD")
            {
                ApplicationArea = Basic, Suite;
            }
            part(MyCustomers; "My Customers")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Advanced;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(ConferenceRegistration)
            {
                ApplicationArea = Basic;
                Caption = 'Conference Registration';
                Image = NewTimesheet;
                RunObject = Page "Conference Card ASD";
                RunPageMode = Create;
            }
            action(SalesInvoice)
            {
                ApplicationArea = Basic;
                Caption = 'Sales Invoice';
                Image = NewInvoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
            }
        }
        area(Embedding)
        {
            action(ConferenceRegistrations)
            {
                ApplicationArea = Basic;
                Caption = 'Conference';
                RunObject = Page "Conference List ASD";
            }
            action(Locations)
            {
                ApplicationArea = Basic;
                Caption = 'Conference Locations';
                RunObject = Page "Conference Location List ASD";
            }
            action(Instructors)
            {
                ApplicationArea = Basic;
                Caption = 'Equipment';
                RunObject = Page "Resource List";
                RunPageView = where(Type = const(Equipment));
            }
            action(Customers)
            {
                ApplicationArea = Basic;
                Caption = 'Customers';
                RunObject = Page "Customer List";
            }
        }
        area(Sections)
        {
            group(PostedDocuments)
            {
                Caption = 'Posted Documents';
                Image = RegisteredDocs;
                action(PostedConferenceRegistrations)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Conference Registrations';
                    RunObject = Page "Posted Conference List ASD";
                }
                action(Registers)
                {
                    ApplicationArea = Basic;
                    Caption = 'Registers';
                    RunObject = Page "Conference List ASD";
                }
            }
        }
        area(Processing)
        {
            action(Navigate)
            {
                ApplicationArea = Basic;
                Caption = 'Navigate';
                Image = Navigate;
                RunObject = Page Navigate;
            }
        }
        area(Reporting)
        {
            // action(ParticipantList)
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Participant List';
            //     Image = "Report";
            //     RunObject = Report "Conference Reg.-Participant List";
            // }
        }
    }
}