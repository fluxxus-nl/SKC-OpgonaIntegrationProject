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
                ApplicationArea = Basic, Suite;
                Caption = 'Conference';
                Image = NewTimesheet;
                RunObject = Page "Conference Card ASD";
                RunPageMode = Create;
            }
        }
        area(Embedding)
        {
            action(ConferenceRegistrations)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Conference';
                RunObject = Page "Conference List ASD";
            }
            action(PostedConferenceRegistrations1)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Conference';
                RunObject = Page "Posted Conference List ASD";
            }
            action(Locations)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Conference Locations';
                RunObject = Page "Conference Location List ASD";
            }
            action(ConferenceLedger)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Conference Ledger Entries';
                RunObject = Page "Conference Ledger Entries ASD";
            }
            action(ConferenceSetup)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Conference Setup';
                RunObject = Page "Conference Setup ASD";
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                RunObject = Page "Customer List";
            }
            action(Item)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item';
                RunObject = Page "Item List";
            }
            action(Resources)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Resources';
                RunObject = Page "Resource List";
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Conference Registrations';
                    RunObject = Page "Posted Conference List ASD";
                }
                action(Registers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Registers';
                    RunObject = Page "Conference List ASD";
                }
            }
        }
        area(Processing)
        {
            action(Navigate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Navigate';
                Image = Navigate;
                RunObject = Page Navigate;
            }
        }
    }
}