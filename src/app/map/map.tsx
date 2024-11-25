'use client'

import * as React from 'react';
import Map, { GeolocateControl } from 'react-map-gl';
import { env } from "@/env";

interface ViewState {
  longitude: number;
  latitude: number;
  zoom: number;
}

export interface AtlasMapProps {
  viewState: ViewState;
  setViewState: React.Dispatch<React.SetStateAction<ViewState>>;
}

export default function AtlasMap({ viewState, setViewState }: AtlasMapProps) {
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