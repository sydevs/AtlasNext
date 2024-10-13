-- Current sql file was generated after introspecting the database
-- If you want to run this migration please uncomment this code before executing migrations
/*
CREATE TABLE IF NOT EXISTS "area_venues" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"area_id" bigint,
	"venue_id" bigint,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "areas" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"country_code" varchar,
	"name" varchar,
	"latitude" double precision,
	"longitude" double precision,
	"radius" double precision,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"last_activity_on" date,
	"summary_email_sent_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"summary_metadata" jsonb DEFAULT '"{}"'::jsonb,
	"time_zone" varchar,
	"region_id" bigint,
	"subtitle" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "audits" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"category" integer DEFAULT 0 NOT NULL,
	"parent_type" varchar,
	"parent_id" bigint,
	"person_type" varchar,
	"person_id" bigint,
	"replies_to_id" bigint,
	"replied_by_id" bigint,
	"conversation_id" bigint,
	"data" jsonb,
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "clients" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"label" varchar NOT NULL,
	"config" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"manager_id" bigint NOT NULL,
	"public_key" varchar NOT NULL,
	"secret_key" varchar NOT NULL,
	"enabled" boolean DEFAULT true NOT NULL,
	"last_accessed_at" timestamp,
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL,
	"location_type" varchar,
	"location_id" bigint
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "conversations" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"marked_complete_at" timestamp(6),
	"last_response_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
	"last_responder_type" varchar,
	"last_responder_id" bigint,
	"parent_type" varchar,
	"parent_id" bigint,
	"uuid" varchar NOT NULL,
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "countries" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"country_code" varchar NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"enable_regions" boolean,
	"last_activity_on" date,
	"summary_email_sent_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"summary_metadata" jsonb DEFAULT '"{}"'::jsonb,
	"default_language_code" varchar(2),
	"name" varchar,
	"enable_custom_regions" boolean DEFAULT false,
	"geojson" jsonb,
	"osm_id" varchar,
	"translations" json DEFAULT '{}'::json NOT NULL,
	"bounds" varchar[] DEFAULT '{""}',
	"mailing_list" jsonb DEFAULT '{}'::jsonb NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "events" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"category" integer DEFAULT 0,
	"custom_name" varchar,
	"room" varchar,
	"description" varchar(600),
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"images" jsonb,
	"manager_id" bigint,
	"published" boolean DEFAULT true,
	"latest_registration_at" timestamp,
	"registration_mode" integer DEFAULT 0,
	"registration_url" varchar,
	"language_code" varchar(2),
	"online_url" varchar,
	"status_email_sent_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"registrations_email_sent_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"should_update_status_at" timestamp DEFAULT CURRENT_TIMESTAMP,
	"verified_at" timestamp DEFAULT CURRENT_TIMESTAMP,
	"expired_at" timestamp,
	"archived_at" timestamp,
	"finished_at" timestamp,
	"status" integer DEFAULT 0 NOT NULL,
	"phone_name" varchar,
	"phone_number" varchar,
	"registration_limit" integer,
	"type" varchar,
	"venue_id" bigint,
	"area_id" bigint,
	"registration_notification" integer DEFAULT 0 NOT NULL,
	"registration_question" integer DEFAULT 1 NOT NULL,
	"contact_info" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"expiration_period" integer DEFAULT 3 NOT NULL,
	"verification_streak" integer DEFAULT 0 NOT NULL,
	"recurrence_data" json DEFAULT '{}'::json,
	"finish_date" date
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "managed_records" (
	"manager_id" integer,
	"record_id" integer,
	"record_type" varchar,
	"id" bigserial PRIMARY KEY NOT NULL,
	"assigned_by_id" integer,
	"created_at" timestamp(6) DEFAULT now() NOT NULL,
	"updated_at" timestamp(6) DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "managers" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"name" varchar,
	"email" varchar,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"administrator" boolean,
	"language_code" varchar(2) DEFAULT 'EN',
	"last_login_at" timestamp,
	"email_verified" boolean,
	"email_verification_sent_at" timestamp,
	"contact_method" integer DEFAULT 0 NOT NULL,
	"phone" varchar,
	"phone_verified" boolean DEFAULT false,
	"phone_verification_sent_at" timestamp,
	"contact_settings" json DEFAULT '{}'::json,
	"notifications" integer DEFAULT 2147483647 NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "passwordless_sessions" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"authenticatable_type" varchar,
	"authenticatable_id" bigint,
	"timeout_at" timestamp NOT NULL,
	"expires_at" timestamp NOT NULL,
	"claimed_at" timestamp,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"token_digest" varchar,
	"identifier" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "pictures" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"parent_type" varchar,
	"parent_id" bigint,
	"file" jsonb,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "regions" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"country_code" varchar NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"last_activity_on" date,
	"summary_email_sent_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"summary_metadata" jsonb DEFAULT '"{}"'::jsonb,
	"geojson" jsonb,
	"name" varchar,
	"osm_id" varchar,
	"translations" json DEFAULT '{}'::json NOT NULL,
	"bounds" varchar[] DEFAULT '{""}'
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "registrations" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"event_id" bigint,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"starting_at" timestamp,
	"time_zone" varchar,
	"questions" jsonb DEFAULT '{}'::jsonb,
	"user_id" bigint,
	"mailing_list_subscribed_at" timestamp(6),
	"reminder_sent_at" timestamp(6),
	"followup_sent_at" timestamp(6),
	"uuid" uuid DEFAULT gen_random_uuid() NOT NULL,
	"next_reminder_at" timestamp(6) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"email" varchar NOT NULL,
	"name" varchar NOT NULL,
	"created_at" timestamp(6) NOT NULL,
	"updated_at" timestamp(6) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "venues" (
	"id" bigserial PRIMARY KEY NOT NULL,
	"name" varchar,
	"latitude" double precision,
	"longitude" double precision,
	"street" varchar,
	"city" varchar,
	"country_code" varchar,
	"post_code" varchar,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"region_code" varchar(3),
	"place_id" varchar,
	"last_activity_on" date,
	"time_zone" varchar
);
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_area_venues_on_area_id" ON "area_venues" USING btree ("area_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_area_venues_on_venue_id" ON "area_venues" USING btree ("venue_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_areas_on_region_id" ON "areas" USING btree ("region_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_audits_on_category" ON "audits" USING btree ("category");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_audits_on_conversation_id" ON "audits" USING btree ("conversation_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_audits_on_parent" ON "audits" USING btree ("parent_type","parent_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_audits_on_person" ON "audits" USING btree ("person_type","person_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_audits_on_replied_by_id" ON "audits" USING btree ("replied_by_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_audits_on_replies_to_id" ON "audits" USING btree ("replies_to_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_clients_on_location" ON "clients" USING btree ("location_type","location_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_clients_on_manager_id" ON "clients" USING btree ("manager_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_conversations_on_last_responder" ON "conversations" USING btree ("last_responder_type","last_responder_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_conversations_on_parent" ON "conversations" USING btree ("parent_type","parent_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_conversations_on_uuid" ON "conversations" USING btree ("uuid");--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "index_countries_on_country_code" ON "countries" USING btree ("country_code");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_events_on_area_id" ON "events" USING btree ("area_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_events_on_manager_id" ON "events" USING btree ("manager_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_events_on_status" ON "events" USING btree ("status");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_events_on_venue_id" ON "events" USING btree ("venue_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_managed_records_on_record_id_and_record_type" ON "managed_records" USING btree ("record_id","record_type");--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "index_managers_on_email" ON "managers" USING btree ("email");--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "index_managers_on_phone" ON "managers" USING btree ("phone");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "authenticatable" ON "passwordless_sessions" USING btree ("authenticatable_type","authenticatable_id");--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "index_passwordless_sessions_on_identifier" ON "passwordless_sessions" USING btree ("identifier");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_passwordless_sessions_on_token_digest" ON "passwordless_sessions" USING btree ("token_digest");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_pictures_on_parent" ON "pictures" USING btree ("parent_type","parent_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_registrations_on_event_id" ON "registrations" USING btree ("event_id");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "index_registrations_on_user_id" ON "registrations" USING btree ("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "index_venues_on_place_id" ON "venues" USING btree ("place_id");
*/