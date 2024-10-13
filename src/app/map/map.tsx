'use client'

import * as React from 'react';
import Map, { GeolocateControl } from 'react-map-gl';
import { env } from "@/env";

export default function AtlasMap() {
  const [viewState, setViewState] = React.useState({
    longitude: -100,
    latitude: 40,
    zoom: 3.5
  });

  return <div className='w-dvw h-dvh fixed'>
    <Map
      mapboxAccessToken={env.NEXT_PUBLIC_MAPBOX_ACCESSTOKEN}
      mapStyle="mapbox://styles/sydevadmin/ck7g6nag70rn11io09f45odkq"
      {...viewState}
      onMove={evt => setViewState(evt.viewState)}
      style={{ width: '100%', height: '100%' }}
      reuseMaps
      attributionControl={false}
    >
      <GeolocateControl />
    </Map>
  </div>;
}