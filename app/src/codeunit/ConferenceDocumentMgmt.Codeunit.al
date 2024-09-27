codeunit 50002 "Conference Document Mgmt ASD"
{

    TableNo = "Conference ASD";

    procedure TransferConferenceDocument(ConferenceASD: Record "Conference ASD")
    var
        ConferenceLineASD: Record "Conference Line ASD";
        PostedConferenceHeaderASD: Record "Posted Conference Header ASD";
        PostedConferenceLineASD: Record "Posted Conference Line ASD";
    begin
        PostedConferenceHeaderASD.Init();
        PostedConferenceHeaderASD.TransferFields(ConferenceASD);
        PostedConferenceHeaderASD.Insert(true);

        ConferenceLineASD.Reset();
        ConferenceLineASD.SetRange("No.", ConferenceASD.DocumentNo);
        if ConferenceLineASD.FindSet() then
            repeat
                PostedConferenceLineASD.Init();
                PostedConferenceLineASD.TransferFields(ConferenceLineASD);
                PostedConferenceLineASD.Insert(true);
            until ConferenceLineASD.Next() = 0;
        ConferenceASD.Delete(true);
    end;
}