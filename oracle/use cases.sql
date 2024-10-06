CREATE TABLE things_to_report_to_Dr_Majdalani (
    thing_to_report_to_Dr_Majdalani_id              RAW(16) DEFAULT sys_guid() PRIMARY KEY,
    thing_to_report_to_Dr_Majdalani                 VARCHAR2(1000) NOT NULL,
    CONSTRAINT unique_thing_to_report_to_Dr_Majdalani UNIQUE ( thing_to_report_to_Dr_Majdalani ),

    -- Additional columns for note and dates
    note                    VARCHAR2(4000),  -- General-purpose note field
    date_created            TIMESTAMP(9) WITH TIME ZONE DEFAULT systimestamp(9) NOT NULL,
    date_updated            TIMESTAMP(9) WITH TIME ZONE,
        date_created_or_updated TIMESTAMP(9) WITH TIME ZONE GENERATED ALWAYS AS ( coalesce(date_updated, date_created) ) VIRTUAL
);

CREATE OR REPLACE TRIGGER trigger_set_date_updated_hero BEFORE
    UPDATE ON things_to_report_to_Dr_Majdalani
    FOR EACH ROW
BEGIN
    :new.date_updated := systimestamp;
END;
/