import { pgTable, index, bigserial, bigint, timestamp, varchar, doublePrecision, date, jsonb, integer, boolean, uniqueIndex, json, uuid } from "drizzle-orm/pg-core"
  import { sql } from "drizzle-orm"




export const areaVenues = pgTable("area_venues", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	areaId: bigint("area_id", { mode: "number" }),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	venueId: bigint("venue_id", { mode: "number" }),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
},
(table) => {
	return {
		indexAreaVenuesOnAreaId: index("index_area_venues_on_area_id").using("btree", table.areaId.asc().nullsLast()),
		indexAreaVenuesOnVenueId: index("index_area_venues_on_venue_id").using("btree", table.venueId.asc().nullsLast()),
	}
});

export const areas = pgTable("areas", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	countryCode: varchar("country_code"),
	name: varchar("name"),
	latitude: doublePrecision("latitude"),
	longitude: doublePrecision("longitude"),
	radius: doublePrecision("radius"),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
	lastActivityOn: date("last_activity_on"),
	summaryEmailSentAt: timestamp("summary_email_sent_at", { mode: 'string' }).default(sql`CURRENT_TIMESTAMP`).notNull(),
	summaryMetadata: jsonb("summary_metadata").default("{}"),
	timeZone: varchar("time_zone"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	regionId: bigint("region_id", { mode: "number" }),
	subtitle: varchar("subtitle"),
},
(table) => {
	return {
		indexAreasOnRegionId: index("index_areas_on_region_id").using("btree", table.regionId.asc().nullsLast()),
	}
});

export const audits = pgTable("audits", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	category: integer("category").default(0).notNull(),
	parentType: varchar("parent_type"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	parentId: bigint("parent_id", { mode: "number" }),
	personType: varchar("person_type"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	personId: bigint("person_id", { mode: "number" }),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	repliesToId: bigint("replies_to_id", { mode: "number" }),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	repliedById: bigint("replied_by_id", { mode: "number" }),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	conversationId: bigint("conversation_id", { mode: "number" }),
	data: jsonb("data"),
	createdAt: timestamp("created_at", { precision: 6, mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { precision: 6, mode: 'string' }).notNull(),
},
(table) => {
	return {
		indexAuditsOnCategory: index("index_audits_on_category").using("btree", table.category.asc().nullsLast()),
		indexAuditsOnConversationId: index("index_audits_on_conversation_id").using("btree", table.conversationId.asc().nullsLast()),
		indexAuditsOnParent: index("index_audits_on_parent").using("btree", table.parentType.asc().nullsLast(), table.parentId.asc().nullsLast()),
		indexAuditsOnPerson: index("index_audits_on_person").using("btree", table.personType.asc().nullsLast(), table.personId.asc().nullsLast()),
		indexAuditsOnRepliedById: index("index_audits_on_replied_by_id").using("btree", table.repliedById.asc().nullsLast()),
		indexAuditsOnRepliesToId: index("index_audits_on_replies_to_id").using("btree", table.repliesToId.asc().nullsLast()),
	}
});

export const clients = pgTable("clients", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	label: varchar("label").notNull(),
	config: jsonb("config").default({}).notNull(),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	managerId: bigint("manager_id", { mode: "number" }).notNull(),
	publicKey: varchar("public_key").notNull(),
	secretKey: varchar("secret_key").notNull(),
	enabled: boolean("enabled").default(true).notNull(),
	lastAccessedAt: timestamp("last_accessed_at", { mode: 'string' }),
	createdAt: timestamp("created_at", { precision: 6, mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { precision: 6, mode: 'string' }).notNull(),
	locationType: varchar("location_type"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	locationId: bigint("location_id", { mode: "number" }),
},
(table) => {
	return {
		indexClientsOnLocation: index("index_clients_on_location").using("btree", table.locationType.asc().nullsLast(), table.locationId.asc().nullsLast()),
		indexClientsOnManagerId: index("index_clients_on_manager_id").using("btree", table.managerId.asc().nullsLast()),
	}
});

export const conversations = pgTable("conversations", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	markedCompleteAt: timestamp("marked_complete_at", { precision: 6, mode: 'string' }),
	lastResponseAt: timestamp("last_response_at", { precision: 6, mode: 'string' }).default(sql`CURRENT_TIMESTAMP`),
	lastResponderType: varchar("last_responder_type"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	lastResponderId: bigint("last_responder_id", { mode: "number" }),
	parentType: varchar("parent_type"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	parentId: bigint("parent_id", { mode: "number" }),
	uuid: varchar("uuid").notNull(),
	createdAt: timestamp("created_at", { precision: 6, mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { precision: 6, mode: 'string' }).notNull(),
},
(table) => {
	return {
		indexConversationsOnLastResponder: index("index_conversations_on_last_responder").using("btree", table.lastResponderType.asc().nullsLast(), table.lastResponderId.asc().nullsLast()),
		indexConversationsOnParent: index("index_conversations_on_parent").using("btree", table.parentType.asc().nullsLast(), table.parentId.asc().nullsLast()),
		indexConversationsOnUuid: index("index_conversations_on_uuid").using("btree", table.uuid.asc().nullsLast()),
	}
});

export const countries = pgTable("countries", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	countryCode: varchar("country_code").notNull(),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
	enableRegions: boolean("enable_regions"),
	lastActivityOn: date("last_activity_on"),
	summaryEmailSentAt: timestamp("summary_email_sent_at", { mode: 'string' }).default(sql`CURRENT_TIMESTAMP`).notNull(),
	summaryMetadata: jsonb("summary_metadata").default("{}"),
	defaultLanguageCode: varchar("default_language_code", { length: 2 }),
	name: varchar("name"),
	enableCustomRegions: boolean("enable_custom_regions").default(false),
	geojson: jsonb("geojson"),
	osmId: varchar("osm_id"),
	translations: json("translations").default({}).notNull(),
	bounds: varchar("bounds").array().default([""]),
	mailingList: jsonb("mailing_list").default({}).notNull(),
},
(table) => {
	return {
		indexCountriesOnCountryCode: uniqueIndex("index_countries_on_country_code").using("btree", table.countryCode.asc().nullsLast()),
	}
});

export const events = pgTable("events", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	category: integer("category").default(0),
	customName: varchar("custom_name"),
	room: varchar("room"),
	description: varchar("description", { length: 600 }),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
	images: jsonb("images"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	managerId: bigint("manager_id", { mode: "number" }),
	published: boolean("published").default(true),
	latestRegistrationAt: timestamp("latest_registration_at", { mode: 'string' }),
	registrationMode: integer("registration_mode").default(0),
	registrationUrl: varchar("registration_url"),
	languageCode: varchar("language_code", { length: 2 }),
	onlineUrl: varchar("online_url"),
	statusEmailSentAt: timestamp("status_email_sent_at", { mode: 'string' }).default(sql`CURRENT_TIMESTAMP`).notNull(),
	registrationsEmailSentAt: timestamp("registrations_email_sent_at", { mode: 'string' }).default(sql`CURRENT_TIMESTAMP`).notNull(),
	shouldUpdateStatusAt: timestamp("should_update_status_at", { mode: 'string' }).default(sql`CURRENT_TIMESTAMP`),
	verifiedAt: timestamp("verified_at", { mode: 'string' }).default(sql`CURRENT_TIMESTAMP`),
	expiredAt: timestamp("expired_at", { mode: 'string' }),
	archivedAt: timestamp("archived_at", { mode: 'string' }),
	finishedAt: timestamp("finished_at", { mode: 'string' }),
	status: integer("status").default(0).notNull(),
	phoneName: varchar("phone_name"),
	phoneNumber: varchar("phone_number"),
	registrationLimit: integer("registration_limit"),
	type: varchar("type"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	venueId: bigint("venue_id", { mode: "number" }),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	areaId: bigint("area_id", { mode: "number" }),
	registrationNotification: integer("registration_notification").default(0).notNull(),
	registrationQuestion: integer("registration_question").default(1).notNull(),
	contactInfo: jsonb("contact_info").default({}).notNull(),
	expirationPeriod: integer("expiration_period").default(3).notNull(),
	verificationStreak: integer("verification_streak").default(0).notNull(),
	recurrenceData: json("recurrence_data").default({}),
	finishDate: date("finish_date"),
},
(table) => {
	return {
		indexEventsOnAreaId: index("index_events_on_area_id").using("btree", table.areaId.asc().nullsLast()),
		indexEventsOnManagerId: index("index_events_on_manager_id").using("btree", table.managerId.asc().nullsLast()),
		indexEventsOnStatus: index("index_events_on_status").using("btree", table.status.asc().nullsLast()),
		indexEventsOnVenueId: index("index_events_on_venue_id").using("btree", table.venueId.asc().nullsLast()),
	}
});

export const managedRecords = pgTable("managed_records", {
	managerId: integer("manager_id"),
	recordId: integer("record_id"),
	recordType: varchar("record_type"),
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	assignedById: integer("assigned_by_id"),
	createdAt: timestamp("created_at", { precision: 6, mode: 'string' }).defaultNow().notNull(),
	updatedAt: timestamp("updated_at", { precision: 6, mode: 'string' }).defaultNow().notNull(),
},
(table) => {
	return {
		indexManagedRecordsOnRecordIdAndRecordType: index("index_managed_records_on_record_id_and_record_type").using("btree", table.recordId.asc().nullsLast(), table.recordType.asc().nullsLast()),
	}
});

export const managers = pgTable("managers", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	name: varchar("name"),
	email: varchar("email"),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
	administrator: boolean("administrator"),
	languageCode: varchar("language_code", { length: 2 }).default('EN'),
	lastLoginAt: timestamp("last_login_at", { mode: 'string' }),
	emailVerified: boolean("email_verified"),
	emailVerificationSentAt: timestamp("email_verification_sent_at", { mode: 'string' }),
	contactMethod: integer("contact_method").default(0).notNull(),
	phone: varchar("phone"),
	phoneVerified: boolean("phone_verified").default(false),
	phoneVerificationSentAt: timestamp("phone_verification_sent_at", { mode: 'string' }),
	contactSettings: json("contact_settings").default({}),
	notifications: integer("notifications").default(2147483647).notNull(),
},
(table) => {
	return {
		indexManagersOnEmail: uniqueIndex("index_managers_on_email").using("btree", table.email.asc().nullsLast()),
		indexManagersOnPhone: uniqueIndex("index_managers_on_phone").using("btree", table.phone.asc().nullsLast()),
	}
});

export const passwordlessSessions = pgTable("passwordless_sessions", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	authenticatableType: varchar("authenticatable_type"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	authenticatableId: bigint("authenticatable_id", { mode: "number" }),
	timeoutAt: timestamp("timeout_at", { mode: 'string' }).notNull(),
	expiresAt: timestamp("expires_at", { mode: 'string' }).notNull(),
	claimedAt: timestamp("claimed_at", { mode: 'string' }),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
	tokenDigest: varchar("token_digest"),
	identifier: varchar("identifier"),
},
(table) => {
	return {
		authenticatable: index("authenticatable").using("btree", table.authenticatableType.asc().nullsLast(), table.authenticatableId.asc().nullsLast()),
		indexPasswordlessSessionsOnIdentifier: uniqueIndex("index_passwordless_sessions_on_identifier").using("btree", table.identifier.asc().nullsLast()),
		indexPasswordlessSessionsOnTokenDigest: index("index_passwordless_sessions_on_token_digest").using("btree", table.tokenDigest.asc().nullsLast()),
	}
});

export const pictures = pgTable("pictures", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	parentType: varchar("parent_type"),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	parentId: bigint("parent_id", { mode: "number" }),
	file: jsonb("file"),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
},
(table) => {
	return {
		indexPicturesOnParent: index("index_pictures_on_parent").using("btree", table.parentType.asc().nullsLast(), table.parentId.asc().nullsLast()),
	}
});

export const regions = pgTable("regions", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	countryCode: varchar("country_code").notNull(),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
	lastActivityOn: date("last_activity_on"),
	summaryEmailSentAt: timestamp("summary_email_sent_at", { mode: 'string' }).default(sql`CURRENT_TIMESTAMP`).notNull(),
	summaryMetadata: jsonb("summary_metadata").default("{}"),
	geojson: jsonb("geojson"),
	name: varchar("name"),
	osmId: varchar("osm_id"),
	translations: json("translations").default({}).notNull(),
	bounds: varchar("bounds").array().default([""]),
});

export const registrations = pgTable("registrations", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	eventId: bigint("event_id", { mode: "number" }),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
	startingAt: timestamp("starting_at", { mode: 'string' }),
	timeZone: varchar("time_zone"),
	questions: jsonb("questions").default({}),
	// You can use { mode: "bigint" } if numbers are exceeding js number limitations
	userId: bigint("user_id", { mode: "number" }),
	mailingListSubscribedAt: timestamp("mailing_list_subscribed_at", { precision: 6, mode: 'string' }),
	reminderSentAt: timestamp("reminder_sent_at", { precision: 6, mode: 'string' }),
	followupSentAt: timestamp("followup_sent_at", { precision: 6, mode: 'string' }),
	uuid: uuid("uuid").defaultRandom().notNull(),
	nextReminderAt: timestamp("next_reminder_at", { precision: 6, mode: 'string' }).notNull(),
},
(table) => {
	return {
		indexRegistrationsOnEventId: index("index_registrations_on_event_id").using("btree", table.eventId.asc().nullsLast()),
		indexRegistrationsOnUserId: index("index_registrations_on_user_id").using("btree", table.userId.asc().nullsLast()),
	}
});

export const users = pgTable("users", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	email: varchar("email").notNull(),
	name: varchar("name").notNull(),
	createdAt: timestamp("created_at", { precision: 6, mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { precision: 6, mode: 'string' }).notNull(),
});

export const venues = pgTable("venues", {
	id: bigserial("id", { mode: "bigint" }).primaryKey().notNull(),
	name: varchar("name"),
	latitude: doublePrecision("latitude"),
	longitude: doublePrecision("longitude"),
	street: varchar("street"),
	city: varchar("city"),
	countryCode: varchar("country_code"),
	postCode: varchar("post_code"),
	createdAt: timestamp("created_at", { mode: 'string' }).notNull(),
	updatedAt: timestamp("updated_at", { mode: 'string' }).notNull(),
	regionCode: varchar("region_code", { length: 3 }),
	placeId: varchar("place_id"),
	lastActivityOn: date("last_activity_on"),
	timeZone: varchar("time_zone"),
},
(table) => {
	return {
		indexVenuesOnPlaceId: uniqueIndex("index_venues_on_place_id").using("btree", table.placeId.asc().nullsLast()),
	}
});