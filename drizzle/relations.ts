import { relations } from "drizzle-orm/relations";
import { countries, regions, areaVenues, areas, venues, events } from "./schema";

export const countriesRelations = relations(countries, ({ many }) => ({
  areaVenues: many(areaVenues),
  regions: many(regions),
  areas: many(areas),
}));

export const regionsRelations = relations(regions, ({ one, many }) => ({
  country: one(countries, {
    fields: [regions.countryCode],
    references: [countries.countryCode],
  }),
  areas: many(areaVenues),
}));

export const areasRelations = relations(areas, ({ one, many }) => ({
  areaVenues: many(areaVenues),
  region: one(regions, {
    fields: [areas.regionId],
    references: [regions.id],
  }),
  country: one(countries, {
    fields: [areas.countryCode],
    references: [countries.countryCode],
  }),
}));

export const areaVenuesRelations = relations(areaVenues, ({ one }) => ({
  area: one(areas, {
    fields: [areaVenues.areaId],
    references: [areas.id],
  }),
  venue: one(venues, {
    fields: [areaVenues.areaId],
    references: [venues.id],
  }),
}));

export const venuesRelations = relations(venues, ({ many }) => ({
  areaVenues: many(areaVenues),
  events: many(events),
}));

export const eventsRelations = relations(events, ({ one }) => ({
  venue: one(venues, {
    fields: [events.areaId],
    references: [venues.id],
  }),
}));
