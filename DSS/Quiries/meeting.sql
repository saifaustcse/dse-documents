select * from COMMITTEE order by 1 desc;
-- select * from COMMITTEE_MEMBERS order by 1; --not used

select * from MEETING order by 1 desc;
select * from MEETING_HIST order by 1 desc; -- for changes history
select * from AGENDA order by 1 desc;
select * from AGENDA_HIST order by 1 desc;  -- for changes history
select * from ACTION_POINT order by 1 desc;
select * from ACTION_POINT_HIST order by 1 desc;       -- for changes history
select * from ACTION_POINT_REMARKS order by 1 desc;

-- select * from ACT_PO_ASSIGNMENT; --not used
-- select * from ACT_PO_FLOW; --not used

-- The WORKFLOW used in CCB and implemented in UAT but has not yet been deployed in the live environment. MCD is currently using Google Forms.
select * from CCBA_BANK_ACCOUNT_ENTRY;
select * from CCBA_INPUT_DETAILS;
select * from WORKFLOW_APPS_LIST;
select * from WORKFLOW_APPS_LIST;