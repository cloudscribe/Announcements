-- The rationale for this script can be found here: https://github.com/cloudscribe/Announcements/issues/7
-- This script can migrate cloudscribe kvp from 
-- <PackageReference Include="cloudscribe.Kvp.Storage.EFCore.pgsql" Version="3.0.1" />
-- to <PackageReference Include="cloudscribe.Kvp.Storage.EFCore.PostgreSql" Version="3.0.2" />
-- Author: Joe Audette Created: 2018-10-21
-- To use this you would first create a site with the new PostgreSql package and let it run initial migrations.
-- Then you would run this script against the new database after editing the v_sourcedb variable to connect to your old db.
-- Learn more about postgresql dblink: https://www.google.com/search?q=postgresql+use+dblink

DO $$
-- edit this to set the connection to your source database
DECLARE v_sourcedb varchar := 'dbname=yoursourcedb user=postgres password=yourpostgrespassword';

BEGIN

CREATE EXTENSION dblink;

-- this is only needed to run more than once
TRUNCATE TABLE kvp_items;

INSERT INTO public.kvp_items
(
	id, 
	created_utc,
	custom1, 
	custom2, 
	feature_id, 
	key, 
	modified_utc,
	set_id, 
	sub_set_id, 
	value
)
	
SELECT 
"Id", 
"CreatedUtc", 
"Custom1", 
"Custom2", 
"FeatureId", 
"Key", 
"ModifiedUtc", 
"SetId", 
"SubSetId", 
"Value"


FROM dblink(v_sourcedb,
                '
		 SELECT 
			"Id", 
			"CreatedUtc", 
			"Custom1", 
			"Custom2", 
			"FeatureId", 
			"Key", 
			"ModifiedUtc", 
			"SetId", 
			"SubSetId", 
			"Value"
	FROM public."KvpItems"
			'
			   )
 AS t2 (
"Id" character varying, 
"CreatedUtc" timestamp without time zone, 
"Custom1" character varying, 
"Custom2" character varying, 
"FeatureId" character varying, 
"Key" character varying, 
"ModifiedUtc" timestamp without time zone, 
"SetId" character varying, 
"SubSetId" character varying, 
"Value" text
 
 ) ;


 
DROP EXTENSION dblink;
	  
END $$;