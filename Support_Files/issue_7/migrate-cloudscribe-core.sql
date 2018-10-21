-- The rationale for this script can be found here: https://github.com/cloudscribe/Announcements/issues/7
-- This script can migrate cloudscribe core from <PackageReference Include="cloudscribe.Core.Storage.EFCore.pgsql" Version="3.0.7" />
-- to <PackageReference Include="cloudscribe.Core.Storage.EFCore.PostgreSql" Version="3.0.7" />
-- Author: Joe Audette Created: 2018-10-20
-- To use this you would first create a site with the new PostgreSql package and let it run initial migrations.
-- Then you would run this script against the new database after editing the v_sourcedb variable to connect to your old db.
-- Learn more about postgresql dblink: https://www.google.com/search?q=postgresql+use+dblink

DO $$
-- edit this to set the connection to your source database
DECLARE v_sourcedb varchar := 'dbname=yoursourcedb user=postgres password=yourpostgrespassword';

BEGIN

CREATE EXTENSION dblink;

-- clean out users and roles created when first running the site
TRUNCATE TABLE cs_user_role;
TRUNCATE TABLE cs_user_login;
TRUNCATE TABLE cs_user_claim;
TRUNCATE TABLE cs_user_location;
TRUNCATE TABLE cs_user_token;
TRUNCATE TABLE cs_user;
TRUNCATE TABLE cs_role;
TRUNCATE TABLE cs_site_host;
TRUNCATE TABLE cs_site;

INSERT INTO public.cs_site(
	id, 
	account_approval_email_csv,
	add_this_dot_com_username, 
	alias_id, 
	allow_db_fallback_with_ldap, 
	allow_new_registration, 
	allow_persistent_login, 
	auto_create_ldap_user_on_first_login, 
	captcha_on_login, 
	captcha_on_registration, 
	company_country, 
	company_fax,
	company_locality, 
	company_name,
	company_phone,
	company_postal_code,  
	company_public_email,
	company_region,
	company_street_address, 
	company_street_address2, 
	company_website,
	concurrency_stamp, 
	created_utc, 
	default_email_from_address, 
	default_email_from_alias,
	disable_db_auth,
	dkim_domain,
	dkim_private_key, 
	dkim_public_key, 
	dkim_selector,
	email_ldap_db_fallback,
	facebook_app_id, 
	facebook_app_secret, 
	google_analytics_profile_id, 
	google_client_id, 
	google_client_secret,
	is_data_protected,
	is_server_admin_site,
	ldap_domain, 
	ldap_port, 
	ldap_root_dn, 
	ldap_server, 
	ldap_user_dn_key, 
	login_info_bottom, 
	login_info_top, 
	max_invalid_password_attempts, 
	microsoft_client_id, 
	microsoft_client_secret,
	min_required_password_length, 
	oid_connect_app_id, 
	oid_connect_app_secret, 
	preferred_host_name, 
	privacy_policy, 
	require_cookie_consent,
	recaptcha_private_key, 
	recaptcha_public_key, 
	registration_agreement, 
	registration_preamble, 
	require_approval_before_login,
	require_confirmed_email, 
	require_confirmed_phone,
	requires_question_and_answer,
	sign_email_with_dkim, 
	site_folder_name, 
	site_is_closed, 
	site_is_closed_message,
	site_name, 
	sms_client_id,
	sms_from,
	sms_secure_token, 
	smtp_password, 
	smtp_port, 
	smtp_preferred_encoding,
	smtp_requires_auth, 
	smtp_server, 
	smtp_use_ssl, 
	smtp_user, 
	theme, 
	time_zone_id,
	twitter_consumer_key, 
	twitter_consumer_secret,
	use_email_for_login, 
	use_ldap_auth,
	use_invisible_recaptcha, 
	oid_connect_authority, 
	terms_updated_utc,
	oid_connect_display_name, 
	forced_culture, 
	forced_ui_culture,
	pwd_require_digit, 
	pwd_require_lowercase, 
	pwd_require_non_alpha, 
	pwd_require_uppercase, 
	email_api_endpoint, 
	email_api_key, 
	email_sender_name,
	cookie_policy_summary,
	last_modified_utc 
)
	

SELECT "Id",
"AccountApprovalEmailCsv",
"AddThisDotComUsername",
"AliasId",
"AllowDbFallbackWithLdap",
"AllowNewRegistration",
"AllowPersistentLogin", 
"AutoCreateLdapUserOnFirstLogin", 
"CaptchaOnLogin", 
"CaptchaOnRegistration",
"CompanyCountry", 
"CompanyFax", 
"CompanyLocality", 
"CompanyName", 
"CompanyPhone", 
"CompanyPostalCode", 
"CompanyPublicEmail", 
"CompanyRegion", 
"CompanyStreetAddress", 
"CompanyStreetAddress2", 
"CompanyWebsite",
"ConcurrencyStamp", 
"CreatedUtc", 
"DefaultEmailFromAddress", 
"DefaultEmailFromAlias", 
"DisableDbAuth", 
"DkimDomain", 
"DkimPrivateKey", 
"DkimPublicKey", 
"DkimSelector", 
"EmailLdapDbFallback", 
"FacebookAppId", 
"FacebookAppSecret", 
"GoogleAnalyticsProfileId", 
"GoogleClientId", 
"GoogleClientSecret", 
"IsDataProtected", 
"IsServerAdminSite", 
"LdapDomain", 
"LdapPort", 
"LdapRootDN", 
"LdapServer", 
"LdapUserDNKey", 
"LoginInfoBottom", 
"LoginInfoTop", 
"MaxInvalidPasswordAttempts", 
"MicrosoftClientId", 
"MicrosoftClientSecret", 
"MinRequiredPasswordLength", 
"OidConnectAppId", 
"OidConnectAppSecret", 
"PreferredHostName", 
"PrivacyPolicy", 
"RequireCookieConsent", 
"RecaptchaPrivateKey", 
"RecaptchaPublicKey", 
"RegistrationAgreement", 
"RegistrationPreamble", 
"RequireApprovalBeforeLogin", 
"RequireConfirmedEmail", 
"RequireConfirmedPhone", 
"RequiresQuestionAndAnswer", 
"SignEmailWithDkim", 
"SiteFolderName", 
"SiteIsClosed", 
"SiteIsClosedMessage", 
"SiteName", 
"SmsClientId", 
"SmsFrom", 
"SmsSecureToken", 
"SmtpPassword", 
"SmtpPort", 
"SmtpPreferredEncoding", 
"SmtpRequiresAuth", 
"SmtpServer", 
"SmtpUseSsl", 
"SmtpUser", 
"Theme", 
"TimeZoneId", 
"TwitterConsumerKey", 
"TwitterConsumerSecret", 
"UseEmailForLogin", 
"UseLdapAuth", 
"UseInvisibleRecaptcha", 
"OidConnectAuthority", 
"TermsUpdatedUtc", 
"OidConnectDisplayName", 
"ForcedCulture", 
"ForcedUICulture", 
"PwdRequireDigit", 
"PwdRequireLowercase", 
"PwdRequireNonAlpha", 
"PwdRequireUppercase", 
"EmailApiEndpoint", 
"EmailApiKey", 
"EmailSenderName", 
"CookiePolicySummary", 
"LastModifiedUtc"

FROM dblink(v_sourcedb,
                'select "Id",
				"AccountApprovalEmailCsv",
                "AddThisDotComUsername",
                "AliasId",
                "AllowDbFallbackWithLdap",
                "AllowNewRegistration", 
                "AllowPersistentLogin", 
                "AutoCreateLdapUserOnFirstLogin", 
                "CaptchaOnLogin", 
                "CaptchaOnRegistration",
				"CompanyCountry", 
"CompanyFax", 
"CompanyLocality", 
"CompanyName", 
"CompanyPhone", 
"CompanyPostalCode", 
"CompanyPublicEmail", 
"CompanyRegion", 
"CompanyStreetAddress", 
"CompanyStreetAddress2", 
"ConcurrencyStamp", 
"CreatedUtc", 
"DefaultEmailFromAddress", 
"DefaultEmailFromAlias", 
"DisableDbAuth", 
"DkimDomain", 
"DkimPrivateKey", 
"DkimPublicKey", 
"DkimSelector", 
"EmailLdapDbFallback", 
"FacebookAppId", 
"FacebookAppSecret", 
"GoogleAnalyticsProfileId", 
"GoogleClientId", 
"GoogleClientSecret", 
"IsDataProtected", 
"IsServerAdminSite", 
"LdapDomain", 
"LdapPort", 
"LdapRootDN", 
"LdapServer", 
"LdapUserDNKey", 
"LoginInfoBottom", 
"LoginInfoTop", 
"MaxInvalidPasswordAttempts", 
"MicrosoftClientId", 
"MicrosoftClientSecret", 
"MinRequiredPasswordLength", 
"OidConnectAppId", 
"OidConnectAppSecret", 
"PreferredHostName", 
"PrivacyPolicy", 
"RequireCookieConsent", 
"RecaptchaPrivateKey", 
"RecaptchaPublicKey", 
"RegistrationAgreement", 
"RegistrationPreamble", 
"RequireApprovalBeforeLogin", 
"RequireConfirmedEmail", 
"RequireConfirmedPhone", 
"RequiresQuestionAndAnswer", 
"SignEmailWithDkim", 
"SiteFolderName", 
"SiteIsClosed", 
"SiteIsClosedMessage", 
"SiteName", 
"SmsClientId", 
"SmsFrom", 
"SmsSecureToken", 
"SmtpPassword", 
"SmtpPort", 
"SmtpPreferredEncoding", 
"SmtpRequiresAuth", 
"SmtpServer", 
"SmtpUseSsl", 
"SmtpUser", 
"Theme", 
"TimeZoneId", 
"TwitterConsumerKey", 
"TwitterConsumerSecret", 
"UseEmailForLogin", 
"UseLdapAuth", 
"UseInvisibleRecaptcha", 
"OidConnectAuthority", 
"TermsUpdatedUtc", 
"OidConnectDisplayName", 
"ForcedCulture", 
"ForcedUICulture", 
"PwdRequireDigit", 
"PwdRequireLowercase", 
"PwdRequireNonAlpha", 
"PwdRequireUppercase", 
"CompanyWebsite", 
"EmailApiEndpoint", 
"EmailApiKey", 
"EmailSenderName", 
"CookiePolicySummary", 
"LastModifiedUtc"
				
from "cs_Site"'
			   )
 AS t1 (
"Id" uuid,
"AccountApprovalEmailCsv" text,
"AddThisDotComUsername" character varying ,
"AliasId" character varying, 
"AllowDbFallbackWithLdap" boolean,
"AllowNewRegistration" boolean, 
"AllowPersistentLogin" boolean, 
"AutoCreateLdapUserOnFirstLogin" boolean, 
"CaptchaOnLogin" boolean, 
"CaptchaOnRegistration" boolean,
"CompanyCountry" character varying, 
"CompanyFax" character varying, 
"CompanyLocality" character varying, 
"CompanyName" character varying, 
"CompanyPhone" character varying, 
"CompanyPostalCode" character varying, 
"CompanyPublicEmail" character varying, 
"CompanyRegion" character varying, 
"CompanyStreetAddress" character varying, 
"CompanyStreetAddress2" character varying, 
"ConcurrencyStamp" character varying, 
"CreatedUtc" timestamp without time zone, 
"DefaultEmailFromAddress" character varying, 
"DefaultEmailFromAlias" character varying, 
"DisableDbAuth" boolean, 
"DkimDomain" character varying, 
"DkimPrivateKey" text, 
"DkimPublicKey" text, 
"DkimSelector" character varying, 
"EmailLdapDbFallback" boolean, 
"FacebookAppId" character varying, 
"FacebookAppSecret" text, 
"GoogleAnalyticsProfileId" character varying, 
"GoogleClientId" character varying, 
"GoogleClientSecret" text, 
"IsDataProtected" boolean, 
"IsServerAdminSite" boolean, 
"LdapDomain" character varying, 
"LdapPort" integer, 
"LdapRootDN" character varying, 
"LdapServer" character varying, 
"LdapUserDNKey" character varying, 
"LoginInfoBottom" text, 
"LoginInfoTop" text, 
"MaxInvalidPasswordAttempts" integer, 
"MicrosoftClientId" character varying, 
"MicrosoftClientSecret" text, 
"MinRequiredPasswordLength" integer, 
"OidConnectAppId" character varying, 
"OidConnectAppSecret" text, 
"PreferredHostName" character varying, 
"PrivacyPolicy" text, 
"RequireCookieConsent" boolean, 
"RecaptchaPrivateKey" character varying, 
"RecaptchaPublicKey" character varying, 
"RegistrationAgreement" text, 
"RegistrationPreamble" text, 
"RequireApprovalBeforeLogin" boolean, 
"RequireConfirmedEmail" boolean, 
"RequireConfirmedPhone" boolean, 
"RequiresQuestionAndAnswer" boolean, 
"SignEmailWithDkim" boolean, 
"SiteFolderName" character varying, 
"SiteIsClosed" boolean, 
"SiteIsClosedMessage" text, 
"SiteName" character varying, 
"SmsClientId" character varying, 
"SmsFrom" character varying, 
"SmsSecureToken" character varying, 
"SmtpPassword" character varying, 
"SmtpPort" integer, 
"SmtpPreferredEncoding" character varying, 
"SmtpRequiresAuth" boolean, 
"SmtpServer" character varying, 
"SmtpUseSsl" boolean, 
"SmtpUser" character varying, 
"Theme" character varying, 
"TimeZoneId" character varying, 
"TwitterConsumerKey" character varying, 
"TwitterConsumerSecret" text, 
"UseEmailForLogin" boolean, 
"UseLdapAuth" boolean, 
"UseInvisibleRecaptcha" boolean, 
"OidConnectAuthority" character varying, 
"TermsUpdatedUtc" timestamp without time zone, 
"OidConnectDisplayName" character varying, 
"ForcedCulture" character varying, 
"ForcedUICulture" character varying, 
"PwdRequireDigit" boolean, 
"PwdRequireLowercase" boolean, 
"PwdRequireNonAlpha" boolean, 
"PwdRequireUppercase" boolean, 
"CompanyWebsite" character varying, 
"EmailApiEndpoint" character varying, 
"EmailApiKey" character varying, 
"EmailSenderName" character varying, 
"CookiePolicySummary" text, 
"LastModifiedUtc" timestamp without time zone
 ) ;
 
 
 INSERT INTO public.cs_user(
	id, 
	access_failed_count, 
	account_approved,
	agreement_accepted_utc, 
	avatar_url, 
	author_bio, 
	can_auto_lockout, 
	comment, 
	created_utc, 
	date_of_birth, 
	display_in_member_list,
	display_name, 
	email, 
	email_confirmed, 
	email_confirm_sent_utc, 
	first_name,
	gender, 
	is_locked_out,
	last_login_utc, 
	last_modified_utc,
	last_name, 
	last_password_change_utc, 
	lockout_end_date_utc, 
	must_change_pwd, 
	new_email, 
	new_email_approved, 
	normalized_email, 
	normalized_user_name,
	password_hash,
	phone_number, 
	phone_number_confirmed, 
	roles_changed,
	security_stamp, 
	signature,
	site_id, 
	time_zone_id, 
	two_factor_enabled,
	user_name, 
	web_site_url	
)


SELECT "Id",
"AccessFailedCount", 
"AccountApproved", 
"AgreementAcceptedUtc", 
"AuthorBio", 
"AvatarUrl", 
"CanAutoLockout", 
"Comment", 
"CreatedUtc", 
"DateOfBirth", 
"DisplayInMemberList", 
"DisplayName", 
"Email", 
"EmailConfirmed", 
"EmailConfirmSentUtc",
"FirstName", 
"Gender", 
"IsLockedOut", 
"LastLoginUtc", 
"LastModifiedUtc", 
"LastName", 
"LastPasswordChangeUtc", 
"LockoutEndDateUtc", 
"MustChangePwd", 
"NewEmail", 
"NewEmailApproved", 
"NormalizedEmail",
"NormalizedUserName", 
"PasswordHash", 
"PhoneNumber", 
"PhoneNumberConfirmed", 
"RolesChanged", 
"SecurityStamp", 
"Signature", 
"SiteId", 
"TimeZoneId", 
"TwoFactorEnabled", 
"UserName", 
"WebSiteUrl"


FROM dblink(v_sourcedb,
                '
			    SELECT "Id", 
"AccessFailedCount", 
"AccountApproved", 
"AgreementAcceptedUtc", 
"AuthorBio", 
"AvatarUrl", 
"CanAutoLockout", 
"Comment", 
"CreatedUtc", 
"DateOfBirth", 
"DisplayInMemberList", 
"DisplayName", 
"Email", 
"EmailConfirmed", 
"EmailConfirmSentUtc",
"FirstName", 
"Gender", 
"IsLockedOut", 
"LastLoginUtc", 
"LastModifiedUtc", 
"LastName", 
"LastPasswordChangeUtc", 
"LockoutEndDateUtc", 
"MustChangePwd", 
"NewEmail", 
"NewEmailApproved", 
"NormalizedEmail",
"NormalizedUserName", 
"PasswordHash", 
"PhoneNumber", 
"PhoneNumberConfirmed", 
"RolesChanged", 
"SecurityStamp", 
"Signature", 
"SiteId", 
"TimeZoneId", 
"TwoFactorEnabled", 
"UserName", 
"WebSiteUrl"

FROM public."cs_User"'
			   )
 AS t2 (
"Id" uuid,
"AccessFailedCount" integer, 
"AccountApproved" boolean, 
"AgreementAcceptedUtc" timestamp without time zone, 
"AuthorBio" text, 
"AvatarUrl" character varying, 
"CanAutoLockout" boolean, 
"Comment" text, 
"CreatedUtc" timestamp without time zone, 
"DateOfBirth" timestamp without time zone, 
"DisplayInMemberList" boolean, 
"DisplayName" character varying, 
"Email" character varying, 
"EmailConfirmed" boolean, 
"EmailConfirmSentUtc" timestamp without time zone,
"FirstName" character varying, 
"Gender" character varying, 
"IsLockedOut" boolean, 
"LastLoginUtc" timestamp without time zone, 
"LastModifiedUtc" timestamp without time zone, 
"LastName" character varying, 
"LastPasswordChangeUtc" timestamp without time zone, 
"LockoutEndDateUtc" timestamp without time zone, 
"MustChangePwd" boolean, 
"NewEmail" character varying, 
"NewEmailApproved" boolean, 
"NormalizedEmail" character varying,
"NormalizedUserName" character varying, 
"PasswordHash" text, 
"PhoneNumber" character varying, 
"PhoneNumberConfirmed" boolean, 
"RolesChanged" boolean, 
"SecurityStamp" character varying, 
"Signature" text, 
"SiteId" uuid, 
"TimeZoneId" character varying, 
"TwoFactorEnabled" boolean, 
"UserName" character varying, 
"WebSiteUrl" character varying
 
 ) ;
 
 INSERT INTO public.cs_role(
	id, 
	normalized_role_name, 
	role_name,
	site_id
)

SELECT "Id",
"NormalizedRoleName", 
"RoleName", 
"SiteId"

FROM dblink(v_sourcedb,
                '
			    SELECT "Id", 
"NormalizedRoleName", 
"RoleName", 
"SiteId"
	FROM public."cs_Role"
			'
			   )
 AS t2 (
"Id" uuid,
"NormalizedRoleName" character varying, 
"RoleName" character varying, 
"SiteId" uuid
 
 ) ;
 
 INSERT INTO public.cs_user_role
(
	user_id,
	role_id
)
 
SELECT "UserId", "RoleId"
	

FROM dblink(v_sourcedb,
                '
			    SELECT "UserId", "RoleId"
	FROM public."cs_UserRole"
			'
			   )
 AS t2 (
"UserId" uuid,
"RoleId" uuid
 
 ) ;
 
 INSERT INTO public.cs_site_host
(
	id, host_name, site_id
)
 
SELECT "Id", "HostName", "SiteId"
	

FROM dblink(v_sourcedb,
                '
			    SELECT "Id", "HostName", "SiteId"
	FROM public."cs_SiteHost"
			'
			   )
 AS t2 (
"Id" uuid, 
"HostName" character varying, 
"SiteId" uuid
 
 ) ;
 
 INSERT INTO public.cs_user_claim
(
	id, 
	claim_type, 
	claim_value,
	site_id,
	user_id
)
 
SELECT "Id", "ClaimType", "ClaimValue", "SiteId", "UserId"
	

FROM dblink(v_sourcedb,
                '
			    SELECT "Id", "ClaimType", "ClaimValue", "SiteId", "UserId"
	FROM public."cs_UserClaim"
			'
			   )
 AS t2 (
"Id" uuid, 
"ClaimType" character varying, 
"ClaimValue" text, 
"SiteId" uuid, 
"UserId" uuid
 
 ) ;
 
 INSERT INTO public.cs_user_login(
	user_id,
	site_id, 
	login_provider, 
	provider_key, 
	provider_display_name
)
 
SELECT "UserId", "SiteId", "LoginProvider", "ProviderKey", "ProviderDisplayName"
	

FROM dblink(v_sourcedb,
                '
			    SELECT "UserId", "SiteId", "LoginProvider", "ProviderKey", "ProviderDisplayName"
	FROM public."cs_UserLogin"
			'
			   )
 AS t2 (
"UserId" uuid, 
"SiteId" uuid, 
"LoginProvider" character varying, 
"ProviderKey" character varying, 
"ProviderDisplayName" character varying
 
 ) ;
 
 INSERT INTO public.cs_user_location(
	id, 
	capture_count, 
	city, 
	continent, 
	country, 
	first_capture_utc, 
	host_name, 
	ip_address, 
	ip_address_long,
	isp, 
	last_capture_utc,
	latitude, 
	longitude,
	region, 
	site_id, 
	time_zone, 
	user_id
	
)
	

 
SELECT "Id", 
			"CaptureCount", 
			"City", 
			"Continent", 
			"Country", 
			"FirstCaptureUtc", 
			"HostName", 
			"IpAddress", 
			"IpAddressLong", 
			"Isp", 
			"LastCaptureUtc", 
			"Latitude", 
			"Longitude", 
			"Region", 
			"SiteId", 
			"TimeZone", 
			"UserId"
	

FROM dblink(v_sourcedb,
                '
			    SELECT "Id", 
			"CaptureCount", 
			"City", 
			"Continent", 
			"Country", 
			"FirstCaptureUtc", 
			"HostName", 
			"IpAddress", 
			"IpAddressLong", 
			"Isp", 
			"LastCaptureUtc", 
			"Latitude", 
			"Longitude", 
			"Region", 
			"SiteId", 
			"TimeZone", 
			"UserId"
	FROM public."cs_UserLocation"
			'
			   )
 AS t2 (
"Id" uuid, 
"CaptureCount" integer, 
"City" character varying, 
"Continent" character varying, 
"Country" character varying, 
"FirstCaptureUtc" timestamp without time zone, 
"HostName" character varying, 
"IpAddress" character varying, 
"IpAddressLong" bigint, 
"Isp" character varying, 
"LastCaptureUtc" timestamp without time zone, 
"Latitude" double precision, 
"Longitude" double precision, 
"Region" character varying, 
"SiteId" uuid, 
"TimeZone" character varying, 
"UserId" uuid
 
 ) ;
 
 INSERT INTO public.cs_user_token
(
	user_id,
	site_id, 
	login_provider, 
	name, 
	value
)
	

SELECT 
"UserId", 
"SiteId", 
"LoginProvider", 
"Name", 
"Value"
	

FROM dblink(v_sourcedb,
                '
			    SELECT "UserId", "SiteId", "LoginProvider", "Name", "Value"
	FROM public."cs_UserToken"
			'
			   )
 AS t2 (
"UserId" uuid, 
"SiteId" uuid, 
"LoginProvider" character varying, 
"Name" character varying, 
"Value" text
 
 ) ;
 
 DROP EXTENSION dblink;
	  
END $$;