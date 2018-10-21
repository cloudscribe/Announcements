-- The rationale for this script can be found here: https://github.com/cloudscribe/Announcements/issues/7
-- This script can migrate cloudscribe simplecontent from 
-- <PackageReference Include="cloudscribe.SimpleContent.Storage.EFCore.pgsql" Version="4.0.4" />
-- to <PackageReference Include="cloudscribe.SimpleContent.Storage.EFCore.PostgreSql" Version="4.0.4" />
-- Author: Joe Audette Created: 2018-10-20
-- To use this you would first create a site with the new PostgreSql package and let it run initial migrations.
-- Then you would run this script against the new database after editing the v_sourcedb variable to connect to your old db.
-- Learn more about postgresql dblink: https://www.google.com/search?q=postgresql+use+dblink

DO $$
-- edit this to set the connection to your source database
DECLARE v_sourcedb varchar := 'dbname=yoursourcedb user=postgres password=yourpostgrespassword';

BEGIN

CREATE EXTENSION dblink;

-- this is only needed to run more than once
TRUNCATE TABLE cs_page_category;
TRUNCATE TABLE cs_page_comment;
TRUNCATE TABLE cs_page_resource;
TRUNCATE TABLE cs_post_category;
TRUNCATE TABLE cs_post_comment;
TRUNCATE TABLE cs_post;
TRUNCATE TABLE cs_content_history;
TRUNCATE TABLE cs_content_project;

INSERT INTO public.cs_content_project
(
	id, 
	add_blog_to_pages_tree, 
	blog_menu_links_to_newest_post,
	blog_page_nav_component_visibility,
	blog_page_position, 
	blog_page_text, 
	cdn_url, 
	channel_categories_csv, 
	channel_rating, 
	channel_time_to_live, 
	comment_notification_email, 
	copyright_notice, 
	days_to_comment, 
	default_content_type, 
	default_feed_items, 
	default_page_slug,
	description, 
	disqus_short_name, 
	facebook_app_id, 
	image, 
	include_pub_date_in_post_urls, 
	language_code, 
	local_media_virtual_path, 
	managing_editor_email, 
	max_feed_items,
	moderate_comments, 
	posts_per_page,
	pub_date_format,
	publisher, 
	publisher_entity_type, 
	publisher_logo_height,
	publisher_logo_url, 
	publisher_logo_width, 
	recaptcha_private_key, 
	recaptcha_public_key, 
	remote_feed_processor_use_agent_fragment, 
	remote_feed_url,
	show_featured_posts_on_default_page,
	show_recent_posts_on_default_page,
	show_title,
	site_name, 
	teaser_mode, 
	teaser_truncation_length,
	teaser_truncation_mode, 
	time_zone_id,
	title, 
	twitter_creator,
	twitter_publisher, 
	use_default_page_as_root_node, 
	webmaster_email 
	 
)
	

SELECT 
"Id", 
"AddBlogToPagesTree", 
"BlogMenuLinksToNewestPost", 
"BlogPageNavComponentVisibility", 
"BlogPagePosition", 
"BlogPageText", 
"CdnUrl", 
"ChannelCategoriesCsv", 
"ChannelRating", 
"ChannelTimeToLive", 
"CommentNotificationEmail", 
"CopyrightNotice", 
"DaysToComment", 
"DefaultContentType", 
"DefaultFeedItems", 
"DefaultPageSlug", 
"Description", 
"DisqusShortName", 
"FacebookAppId", 
"Image", 
"IncludePubDateInPostUrls", 
"LanguageCode", 
"LocalMediaVirtualPath", 
"ManagingEditorEmail", 
"MaxFeedItems",
"ModerateComments", 
"PostsPerPage", 
"PubDateFormat", 
"Publisher", 
"PublisherEntityType", 
"PublisherLogoHeight", 
"PublisherLogoUrl", 
"PublisherLogoWidth", 
"RecaptchaPrivateKey", 
"RecaptchaPublicKey", 
"RemoteFeedProcessorUseAgentFragment", 
"RemoteFeedUrl", 
"ShowFeaturedPostsOnDefaultPage",
"ShowRecentPostsOnDefaultPage",
"ShowTitle", 
"SiteName",
"TeaserMode",
"TeaserTruncationLength", 
"TeaserTruncationMode", 
"TimeZoneId", 
"Title", 
"TwitterCreator", 
"TwitterPublisher", 
"UseDefaultPageAsRootNode", 
"WebmasterEmail"

FROM dblink(v_sourcedb,
                '
			    SELECT 
			"Id", 
			"AddBlogToPagesTree", 
			"BlogMenuLinksToNewestPost", 
			"BlogPageNavComponentVisibility", 
			"BlogPagePosition", 
			"BlogPageText", 
			"CdnUrl", 
			"ChannelCategoriesCsv", 
			"ChannelRating", 
			"ChannelTimeToLive", 
			"CommentNotificationEmail", 
			"CopyrightNotice", 
			"DaysToComment", 
			"DefaultPageSlug", 
			"Description", 
			"Image", 
			"IncludePubDateInPostUrls", 
			"LanguageCode", 
			"LocalMediaVirtualPath", 
			"ManagingEditorEmail", 
			"ModerateComments", 
			"PostsPerPage", 
			"PubDateFormat", 
			"RecaptchaPrivateKey", 
			"RecaptchaPublicKey", 
			"RemoteFeedProcessorUseAgentFragment", 
			"RemoteFeedUrl", 
			"ShowTitle", 
			"TimeZoneId", 
			"Title", 
			"UseDefaultPageAsRootNode", 
			"WebmasterEmail", 
			"Publisher", 
			"PublisherLogoUrl", 
			"DisqusShortName", 
			"PublisherLogoHeight", 
			"PublisherLogoWidth", 
			"PublisherEntityType", 
			"ShowRecentPostsOnDefaultPage", 
			"ShowFeaturedPostsOnDefaultPage", 
			"FacebookAppId", 
			"SiteName", 
			"TwitterCreator", 
			"TwitterPublisher", 
			"DefaultContentType", 
			"TeaserTruncationLength", 
			"TeaserTruncationMode", 
			"TeaserMode", 
			"DefaultFeedItems", 
			"MaxFeedItems"
	FROM public."cs_ContentProject"
			'
			   )
 AS t2 (
"Id" character varying, 
"AddBlogToPagesTree" boolean, 
"BlogMenuLinksToNewestPost" boolean, 
"BlogPageNavComponentVisibility" character varying, 
"BlogPagePosition" integer, 
"BlogPageText" character varying, 
"CdnUrl" character varying, 
"ChannelCategoriesCsv" character varying, 
"ChannelRating" character varying, 
"ChannelTimeToLive" integer, 
"CommentNotificationEmail" character varying, 
"CopyrightNotice" character varying, 
"DaysToComment" integer, 
"DefaultPageSlug" character varying, 
"Description" text, 
"Image" character varying, 
"IncludePubDateInPostUrls" boolean, 
"LanguageCode" character varying, 
"LocalMediaVirtualPath" character varying, 
"ManagingEditorEmail" character varying, 
"ModerateComments" boolean, 
"PostsPerPage" integer, 
"PubDateFormat" character varying, 
"RecaptchaPrivateKey" character varying, 
"RecaptchaPublicKey" character varying, 
"RemoteFeedProcessorUseAgentFragment" character varying, 
"RemoteFeedUrl" character varying, 
"ShowTitle" boolean, 
"TimeZoneId" character varying, 
"Title" character varying, 
"UseDefaultPageAsRootNode" boolean, 
"WebmasterEmail" character varying, 
"Publisher" character varying, 
"PublisherLogoUrl" character varying, 
"DisqusShortName" character varying, 
"PublisherLogoHeight" character varying, 
"PublisherLogoWidth" character varying, 
"PublisherEntityType" character varying, 
"ShowRecentPostsOnDefaultPage" boolean, 
"ShowFeaturedPostsOnDefaultPage" boolean, 
"FacebookAppId" character varying, 
"SiteName" character varying, 
"TwitterCreator" character varying, 
"TwitterPublisher" character varying, 
"DefaultContentType" character varying, 
"TeaserTruncationLength" integer, 
"TeaserTruncationMode" smallint, 
"TeaserMode" smallint, 
"DefaultFeedItems" integer, 
"MaxFeedItems" integer
 
 ) ;
 
INSERT INTO public.cs_post
(
	id, 
	author, 
	auto_teaser, 
	blog_id, 
	categories_csv, 
	content, 
	content_type, 
	correlation_key,
	created_by_user,
	created_utc, 
	draft_author, 
	draft_content, 
	draft_pub_date, 
	draft_serialized_model, 
	image_url, 
	is_featured, 
	is_published, 
	last_modified, 
	last_modified_by_user, 
	meta_description, 
	meta_html,
	meta_json, 
	pub_date, 
	serialized_model,
	serializer,
	slug, 
	suppress_teaser,
	teaser_override,
	template_key, 
	thumbnail_url,
	title
	 
)
	
SELECT 
"Id", 
"Author", 
"AutoTeaser",
"BlogId", 
"CategoriesCsv", 
"Content", 
"ContentType", 
"CorrelationKey",
"CreatedByUser", 
"CreatedUtc", 
"DraftAuthor", 
"DraftContent", 
"DraftPubDate", 
"DraftSerializedModel",
"ImageUrl", 
"IsFeatured", 
"IsPublished", 
"LastModified", 
"LastModifiedByUser", 
"MetaDescription", 
"MetaHtml", 
"MetaJson", 
"PubDate", 
"SerializedModel", 
"Serializer",
"Slug", 
"SuppressTeaser",
"TeaserOverride", 
"TemplateKey",
"ThumbnailUrl", 
"Title"

FROM dblink(v_sourcedb,
                '
		 SELECT 
			"Id", 
			"Author", 
			"BlogId", 
			"CategoriesCsv", 
			"Content", 
			"IsPublished", 
			"LastModified", 
			"MetaDescription", 
			"PubDate", 
			"Slug", 
			"Title", 
			"CorrelationKey", 
			"MetaHtml", 
			"MetaJson", 
			"ImageUrl", 
			"IsFeatured", 
			"ThumbnailUrl", 
			"ContentType", 
			"SuppressTeaser", 
			"TeaserOverride", 
			"CreatedByUser", 
			"CreatedUtc", 
			"DraftAuthor", 
			"DraftContent", 
			"DraftPubDate", 
			"DraftSerializedModel", 
			"LastModifiedByUser", 
			"SerializedModel", 
			"Serializer", 
			"TemplateKey", 
			"AutoTeaser"
	FROM public."cs_Post"
			'
			   )
 AS t2 (
"Id" character varying, 
"Author" character varying, 
"BlogId" character varying, 
"CategoriesCsv" text, 
"Content" text, 
"IsPublished" boolean, 
"LastModified" timestamp without time zone, 
"MetaDescription" text, 
"PubDate" timestamp without time zone, 
"Slug" character varying, 
"Title" character varying, 
"CorrelationKey" character varying, 
"MetaHtml" text, 
"MetaJson" text, 
"ImageUrl" character varying, 
"IsFeatured" boolean, 
"ThumbnailUrl" character varying, 
"ContentType" character varying, 
"SuppressTeaser" boolean, 
"TeaserOverride" text, 
"CreatedByUser" character varying, 
"CreatedUtc" timestamp without time zone, 
"DraftAuthor" character varying, 
"DraftContent" text, 
"DraftPubDate" timestamp without time zone, 
"DraftSerializedModel" text, 
"LastModifiedByUser" character varying, 
"SerializedModel" text, 
"Serializer" character varying, 
"TemplateKey" character varying, 
"AutoTeaser" text
 
 ) ;
 
 INSERT INTO public.cs_post_category
(
	value, 
	post_entity_id, 
	project_id
)
	
SELECT 
"Value", "PostEntityId", "ProjectId"

FROM dblink(v_sourcedb,
                '
		 SELECT "Value", "PostEntityId", "ProjectId"
	FROM public."cs_PostCategory"
			'
			   )
 AS t2 (
"Value" character varying, 
"PostEntityId" character varying, 
"ProjectId" character varying
 
 ) ;
 
 INSERT INTO public.cs_post_comment
(
	id, 
	author, 
	email, 
	content, 
	ip, 
	is_admin, 
	is_approved,
	post_entity_id, 
	project_id, 
	pub_date, 
	user_agent, 
	website
)
		
SELECT 
"Id", 
"Author", 
"Content", 
"Email", 
"Ip", 
"IsAdmin", 
"IsApproved", 
"PostEntityId", 
"ProjectId", 
"PubDate", 
"UserAgent", 
"Website"

FROM dblink(v_sourcedb,
                '
		 SELECT 
			"Id", 
			"Author", 
			"Content", 
			"Email", 
			"Ip", 
			"IsAdmin", 
			"IsApproved", 
			"PostEntityId", 
			"ProjectId", 
			"PubDate", 
			"UserAgent", 
			"Website"
	FROM public."cs_PostComment"
			'
			   )
 AS t2 (
"Id" character varying, 
"Author" character varying, 
"Content" text, 
"Email" character varying, 
"Ip" character varying, 
"IsAdmin" boolean, 
"IsApproved" boolean, 
"PostEntityId" character varying, 
"ProjectId" character varying, 
"PubDate" timestamp without time zone, 
"UserAgent" character varying, 
"Website" character varying
 
 ) ;
 
INSERT INTO public.cs_page
(
	id, 
	author, 
	categories_csv, 
	content, 
	content_type, 
	correlation_key, 
	created_by_user, 
	created_utc, 
	disable_editor, 
	draft_author,
	draft_content, 
	draft_pub_date, 
	draft_serialized_model, 
	external_url, 
	is_published,
	last_modified,
	last_modified_by_user,
	menu_filters, 
	menu_only, 
	meta_description, 
	meta_html, 
	meta_json, 
	page_order,
	parent_id, 
	parent_slug, 
	project_id, 
	pub_date, 
	serialized_model, 
	serializer,
	show_categories, 
	show_comments, 
	show_heading,
	show_last_modified,
	show_menu, 
	show_pub_date, 
	slug, 
	template_key, 
	title, 
	view_roles
)
	

		
SELECT 
"Id", 
"Author", 
"CategoriesCsv", 
"Content", 
"ContentType", 
"CorrelationKey", 
"CreatedByUser", 
"CreatedUtc", 
"DisableEditor", 
"DraftAuthor", 
"DraftContent", 
"DraftPubDate", 
"DraftSerializedModel", 
"ExternalUrl", 
"IsPublished", 
"LastModified",
"LastModifiedByUser",
"MenuFilters",
"MenuOnly", 
"MetaDescription", 
"MetaHtml", 
"MetaJson", 
"PageOrder", 
"ParentId", 
"ParentSlug", 
"ProjectId", 
"PubDate", 
"SerializedModel", 
"Serializer", 
"ShowCategories", 
"ShowComments", 
"ShowHeading", 
"ShowLastModified", 
"ShowMenu", 
"ShowPubDate", 
"Slug", 
"TemplateKey",
"Title", 
"ViewRoles"


FROM dblink(v_sourcedb,
                '
		 SELECT 
			"Id", 
			"Author", 
			"CategoriesCsv", 
			"Content", 
			"IsPublished", 
			"LastModified",
			"MenuOnly", 
			"MetaDescription", 
			"PageOrder", 
			"ParentId", 
			"ParentSlug", 
			"ProjectId", 
			"PubDate", 
			"ShowCategories", 
			"ShowComments", 
			"ShowHeading", 
			"ShowLastModified", 
			"ShowPubDate", 
			"Slug", 
			"Title", 
			"ViewRoles", 
			"CorrelationKey", 
			"ExternalUrl", 
			"ShowMenu", 
			"MenuFilters", 
			"MetaHtml", 
			"MetaJson", 
			"DisableEditor", 
			"ContentType", 
			"CreatedByUser", 
			"CreatedUtc", 
			"DraftAuthor", 
			"DraftContent", 
			"DraftPubDate", 
			"DraftSerializedModel", 
			"LastModifiedByUser", 
			"SerializedModel", 
			"Serializer", 
			"TemplateKey"
	FROM public."cs_Page"
			'
			   )
 AS t2 (
"Id" character varying, 
"Author" character varying, 
"CategoriesCsv" text, 
"Content" text, 
"IsPublished" boolean, 
"LastModified" timestamp without time zone,
"MenuOnly" boolean, 
"MetaDescription" text, 
"PageOrder" integer, 
"ParentId" character varying, 
"ParentSlug" character varying, 
"ProjectId" character varying, 
"PubDate" timestamp without time zone, 
"ShowCategories" boolean, 
"ShowComments" boolean, 
"ShowHeading" boolean, 
"ShowLastModified" boolean, 
"ShowPubDate" boolean, 
"Slug" character varying, 
"Title" character varying, 
"ViewRoles" text, 
"CorrelationKey" character varying, 
"ExternalUrl" character varying, 
"ShowMenu" boolean, 
"MenuFilters" character varying, 
"MetaHtml" text, 
"MetaJson" text, 
"DisableEditor" boolean, 
"ContentType" character varying, 
"CreatedByUser" character varying, 
"CreatedUtc" timestamp without time zone, 
"DraftAuthor" character varying, 
"DraftContent" text, 
"DraftPubDate" timestamp without time zone, 
"DraftSerializedModel" text, 
"LastModifiedByUser" character varying, 
"SerializedModel" text, 
"Serializer" character varying, 
"TemplateKey" character varying
 
 ) ;
 
INSERT INTO public.cs_page_resource
(
	id, 
	environment, 
	page_entity_id, 
	sort, 
	type, 
	url
)	

	
SELECT 
"Id", 
"Environment", 
"PageEntityId", 
"Sort", 
"Type", 
"Url"


FROM dblink(v_sourcedb,
                '
		 SELECT 
			"Id", 
			"Environment", 
			"PageEntityId", 
			"Sort", 
			"Type", 
			"Url"
	FROM public."cs_PageResource"
			'
			   )
 AS t2 (
"Id" character varying, 
"Environment" character varying, 
"PageEntityId" character varying, 
"Sort" integer, 
"Type" character varying, 
"Url" character varying
 
 ) ;
 
 INSERT INTO public.cs_content_history
(
	id, 
	author,
	archived_by,
	archived_utc, 
	categories_csv, 
	content, 
	content_id, 
	content_source, 
	content_type, 
	correlation_key,
	created_by_user, 
	created_utc, 
	draft_author, 
	draft_content, 
	draft_pub_date, 
	draft_serialized_model, 
	is_draft_hx,
	is_published, 
	last_modified, 
	last_modified_by_user, 
	meta_description,
	meta_html, 
	meta_json, 
	page_order, 
	parent_id, 
	parent_slug,
	project_id, 
	pub_date, 
	serialized_model, 
	serializer, 
	slug, 
	teaser_override,
	template_key, 
	title, 
	view_roles, 
	was_deleted 
	
)
	
	
SELECT 
"Id", 
"Author",
"ArchivedBy", 
"ArchivedUtc", 
"CategoriesCsv",
"Content", 
"ContentId", 
"ContentSource", 
"ContentType", 
"CorrelationKey", 
"CreatedByUser", 
"CreatedUtc", 
"DraftAuthor", 
"DraftContent", 
"DraftPubDate", 
"DraftSerializedModel",
"IsDraftHx", 
"IsPublished", 
"LastModified", 
"LastModifiedByUser", 
"MetaDescription", 
"MetaHtml", 
"MetaJson", 
"PageOrder", 
"ParentId", 
"ParentSlug",
"ProjectId", 
"PubDate", 
"SerializedModel",
"Serializer",
"Slug", 
"TeaserOverride", 
"TemplateKey", 
"Title", 
"ViewRoles", 
"WasDeleted"


FROM dblink(v_sourcedb,
                '
		 SELECT 
			"Id", 
			"ContentId", 
			"ProjectId", 
			"ContentSource", 
			"ContentType", 
			"Slug", 
			"IsDraftHx", 
			"WasDeleted", 
			"ArchivedUtc", 
			"ArchivedBy", 
			"Title", 
			"Author",
			"CorrelationKey", 
			"Content", 
			"PubDate", 
			"LastModified", 
			"IsPublished", 
			"CreatedUtc", 
			"CreatedByUser", 
			"LastModifiedByUser", 
			"DraftContent", 
			"DraftAuthor", 
			"DraftPubDate", 
			"SerializedModel", 
			"DraftSerializedModel", 
			"TeaserOverride", 
			"MetaDescription", 
			"MetaHtml", 
			"MetaJson", 
			"PageOrder", 
			"ParentId", 
			"ParentSlug", 
			"Serializer", 
			"TemplateKey", 
			"ViewRoles", 
			"CategoriesCsv"
	FROM public."cs_ContentHistory"
			'
			   )
 AS t2 (
"Id" uuid, 
"ContentId" character varying, 
"ProjectId" character varying, 
"ContentSource" character varying, 
"ContentType" character varying, 
"Slug" character varying, 
"IsDraftHx" boolean, 
"WasDeleted" boolean, 
"ArchivedUtc" timestamp without time zone, 
"ArchivedBy" character varying, 
"Title" character varying, 
"Author" character varying,
"CorrelationKey" character varying, 
"Content" text, 
"PubDate" timestamp without time zone, 
"LastModified" timestamp without time zone, 
"IsPublished" boolean, 
"CreatedUtc" timestamp without time zone, 
"CreatedByUser" character varying, 
"LastModifiedByUser" character varying, 
"DraftContent" text, 
"DraftAuthor" character varying, 
"DraftPubDate" timestamp without time zone, 
"SerializedModel" text, 
"DraftSerializedModel" text, 
"TeaserOverride" text, 
"MetaDescription" text, 
"MetaHtml" text, 
"MetaJson" text, 
"PageOrder" integer, 
"ParentId" character varying, 
"ParentSlug" character varying, 
"Serializer" character varying, 
"TemplateKey" character varying, 
"ViewRoles" text, 
"CategoriesCsv" text
 
 ) ;

 
DROP EXTENSION dblink;
	  
END $$;