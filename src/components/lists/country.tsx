import * as React from 'react';
import db from '@/server/db'
import ListItem from '../list-item';

interface CountryItemProps {
  country: {
    id: bigint
    name: string | null
    country_code: string
  }
}

export async function CountryItem({
  country
}: CountryItemProps) {
  const venues = await db.venues.findMany({
    select: { id: true },
    where: { country_code: country.country_code }
  })

  const eventCount = await db.events.count({
    where: { venue_id: { in: venues.map(venue => venue.id) } }
  })

  return <ListItem title={country.name ?? ''} count={eventCount} link={"/map/country/"+country.id} />
}

export default async function CountryList() {
  const countries = await db.countries.findMany({
    select: {
      id: true,
      name: true,
      country_code: true
    },
  })

  return <ul className="h-full w-full overflow-y-auto">
    {countries.map((country) => <CountryItem key={country.id} country={country} />)}
  </ul>
}