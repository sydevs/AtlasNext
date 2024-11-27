-- CreateTable
CREATE TABLE "area_venues" (
    "id" BIGSERIAL NOT NULL,
    "area_id" BIGINT,
    "venue_id" BIGINT,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "area_venues_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "areas" (
    "id" BIGSERIAL NOT NULL,
    "country_code" VARCHAR,
    "name" VARCHAR,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "radius" DOUBLE PRECISION,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "last_activity_on" DATE,
    "summary_email_sent_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "summary_metadata" JSONB DEFAULT '"{}"',
    "time_zone" VARCHAR,
    "region_id" BIGINT,
    "subtitle" VARCHAR,

    CONSTRAINT "areas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audits" (
    "id" BIGSERIAL NOT NULL,
    "category" INTEGER NOT NULL DEFAULT 0,
    "parent_type" VARCHAR,
    "parent_id" BIGINT,
    "person_type" VARCHAR,
    "person_id" BIGINT,
    "replies_to_id" BIGINT,
    "replied_by_id" BIGINT,
    "conversation_id" BIGINT,
    "data" JSONB,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "audits_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clients" (
    "id" BIGSERIAL NOT NULL,
    "label" VARCHAR NOT NULL,
    "config" JSONB NOT NULL DEFAULT '{}',
    "manager_id" BIGINT NOT NULL,
    "public_key" VARCHAR NOT NULL,
    "secret_key" VARCHAR NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "last_accessed_at" TIMESTAMP(6),
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "location_type" VARCHAR,
    "location_id" BIGINT,

    CONSTRAINT "clients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations" (
    "id" BIGSERIAL NOT NULL,
    "marked_complete_at" TIMESTAMP(6),
    "last_response_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "last_responder_type" VARCHAR,
    "last_responder_id" BIGINT,
    "parent_type" VARCHAR,
    "parent_id" BIGINT,
    "uuid" VARCHAR NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "conversations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "countries" (
    "id" BIGSERIAL NOT NULL,
    "country_code" VARCHAR NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "enable_regions" BOOLEAN,
    "last_activity_on" DATE,
    "summary_email_sent_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "summary_metadata" JSONB DEFAULT '"{}"',
    "default_language_code" VARCHAR(2),
    "name" VARCHAR,
    "enable_custom_regions" BOOLEAN DEFAULT false,
    "geojson" JSONB,
    "osm_id" VARCHAR,
    "translations" JSON NOT NULL DEFAULT '{}',
    "bounds" VARCHAR[] DEFAULT ARRAY[]::VARCHAR[],
    "mailing_list" JSONB NOT NULL DEFAULT '{}',

    CONSTRAINT "countries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "events" (
    "id" BIGSERIAL NOT NULL,
    "category" INTEGER DEFAULT 0,
    "custom_name" VARCHAR,
    "room" VARCHAR,
    "description" VARCHAR(600),
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "images" JSONB,
    "manager_id" BIGINT,
    "published" BOOLEAN DEFAULT true,
    "latest_registration_at" TIMESTAMP(6),
    "registration_mode" INTEGER DEFAULT 0,
    "registration_url" VARCHAR,
    "language_code" VARCHAR(2),
    "online_url" VARCHAR,
    "status_email_sent_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "registrations_email_sent_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "should_update_status_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "verified_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "expired_at" TIMESTAMP(6),
    "archived_at" TIMESTAMP(6),
    "finished_at" TIMESTAMP(6),
    "status" INTEGER NOT NULL DEFAULT 0,
    "phone_name" VARCHAR,
    "phone_number" VARCHAR,
    "registration_limit" INTEGER,
    "type" VARCHAR,
    "venue_id" BIGINT,
    "area_id" BIGINT,
    "registration_notification" INTEGER NOT NULL DEFAULT 0,
    "registration_question" INTEGER NOT NULL DEFAULT 1,
    "contact_info" JSONB NOT NULL DEFAULT '{}',
    "expiration_period" INTEGER NOT NULL DEFAULT 3,
    "verification_streak" INTEGER NOT NULL DEFAULT 0,
    "recurrence_data" JSON DEFAULT '{}',
    "finish_date" DATE,

    CONSTRAINT "events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "managed_records" (
    "manager_id" INTEGER,
    "record_id" INTEGER,
    "record_type" VARCHAR,
    "id" BIGSERIAL NOT NULL,
    "assigned_by_id" INTEGER,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "managed_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "managers" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR,
    "email" VARCHAR,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "administrator" BOOLEAN,
    "language_code" VARCHAR(2) DEFAULT 'EN',
    "last_login_at" TIMESTAMP(6),
    "email_verified" BOOLEAN,
    "email_verification_sent_at" TIMESTAMP(6),
    "contact_method" INTEGER NOT NULL DEFAULT 0,
    "phone" VARCHAR,
    "phone_verified" BOOLEAN DEFAULT false,
    "phone_verification_sent_at" TIMESTAMP(6),
    "contact_settings" JSON DEFAULT '{}',
    "notifications" INTEGER NOT NULL DEFAULT 2147483647,

    CONSTRAINT "managers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "passwordless_sessions" (
    "id" BIGSERIAL NOT NULL,
    "authenticatable_type" VARCHAR,
    "authenticatable_id" BIGINT,
    "timeout_at" TIMESTAMP(6) NOT NULL,
    "expires_at" TIMESTAMP(6) NOT NULL,
    "claimed_at" TIMESTAMP(6),
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "token_digest" VARCHAR,
    "identifier" VARCHAR,

    CONSTRAINT "passwordless_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pictures" (
    "id" BIGSERIAL NOT NULL,
    "parent_type" VARCHAR,
    "parent_id" BIGINT,
    "file" JSONB,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "pictures_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "regions" (
    "id" BIGSERIAL NOT NULL,
    "country_code" VARCHAR NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "last_activity_on" DATE,
    "summary_email_sent_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "summary_metadata" JSONB DEFAULT '"{}"',
    "geojson" JSONB,
    "name" VARCHAR,
    "osm_id" VARCHAR,
    "translations" JSON NOT NULL DEFAULT '{}',
    "bounds" VARCHAR[] DEFAULT ARRAY[]::VARCHAR[],

    CONSTRAINT "regions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "registrations" (
    "id" BIGSERIAL NOT NULL,
    "event_id" BIGINT,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "starting_at" TIMESTAMP(6),
    "time_zone" VARCHAR,
    "questions" JSONB DEFAULT '{}',
    "user_id" BIGINT,
    "mailing_list_subscribed_at" TIMESTAMP(6),
    "reminder_sent_at" TIMESTAMP(6),
    "followup_sent_at" TIMESTAMP(6),
    "uuid" UUID NOT NULL DEFAULT gen_random_uuid(),
    "next_reminder_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "registrations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" BIGSERIAL NOT NULL,
    "email" VARCHAR NOT NULL,
    "name" VARCHAR NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "venues" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "street" VARCHAR,
    "city" VARCHAR,
    "country_code" VARCHAR,
    "post_code" VARCHAR,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "region_code" VARCHAR(3),
    "place_id" VARCHAR,
    "last_activity_on" DATE,
    "time_zone" VARCHAR,

    CONSTRAINT "venues_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "index_area_venues_on_area_id" ON "area_venues"("area_id");

-- CreateIndex
CREATE INDEX "index_area_venues_on_venue_id" ON "area_venues"("venue_id");

-- CreateIndex
CREATE INDEX "index_areas_on_region_id" ON "areas"("region_id");

-- CreateIndex
CREATE INDEX "index_audits_on_category" ON "audits"("category");

-- CreateIndex
CREATE INDEX "index_audits_on_conversation_id" ON "audits"("conversation_id");

-- CreateIndex
CREATE INDEX "index_audits_on_parent" ON "audits"("parent_type", "parent_id");

-- CreateIndex
CREATE INDEX "index_audits_on_person" ON "audits"("person_type", "person_id");

-- CreateIndex
CREATE INDEX "index_audits_on_replied_by_id" ON "audits"("replied_by_id");

-- CreateIndex
CREATE INDEX "index_audits_on_replies_to_id" ON "audits"("replies_to_id");

-- CreateIndex
CREATE INDEX "index_clients_on_location" ON "clients"("location_type", "location_id");

-- CreateIndex
CREATE INDEX "index_clients_on_manager_id" ON "clients"("manager_id");

-- CreateIndex
CREATE INDEX "index_conversations_on_last_responder" ON "conversations"("last_responder_type", "last_responder_id");

-- CreateIndex
CREATE INDEX "index_conversations_on_parent" ON "conversations"("parent_type", "parent_id");

-- CreateIndex
CREATE INDEX "index_conversations_on_uuid" ON "conversations"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "index_countries_on_country_code" ON "countries"("country_code");

-- CreateIndex
CREATE INDEX "index_events_on_area_id" ON "events"("area_id");

-- CreateIndex
CREATE INDEX "index_events_on_manager_id" ON "events"("manager_id");

-- CreateIndex
CREATE INDEX "index_events_on_status" ON "events"("status");

-- CreateIndex
CREATE INDEX "index_events_on_venue_id" ON "events"("venue_id");

-- CreateIndex
CREATE INDEX "index_managed_records_on_record_id_and_record_type" ON "managed_records"("record_id", "record_type");

-- CreateIndex
CREATE UNIQUE INDEX "index_managers_on_email" ON "managers"("email");

-- CreateIndex
CREATE UNIQUE INDEX "index_managers_on_phone" ON "managers"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "index_passwordless_sessions_on_identifier" ON "passwordless_sessions"("identifier");

-- CreateIndex
CREATE INDEX "authenticatable" ON "passwordless_sessions"("authenticatable_type", "authenticatable_id");

-- CreateIndex
CREATE INDEX "index_passwordless_sessions_on_token_digest" ON "passwordless_sessions"("token_digest");

-- CreateIndex
CREATE INDEX "index_pictures_on_parent" ON "pictures"("parent_type", "parent_id");

-- CreateIndex
CREATE INDEX "index_registrations_on_event_id" ON "registrations"("event_id");

-- CreateIndex
CREATE INDEX "index_registrations_on_user_id" ON "registrations"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "index_venues_on_place_id" ON "venues"("place_id");

