'use client'

import * as React from 'react';
import AtlasMap from './map';
import CountryList from '@/components/lists/country';

export default function MapPage() {
  const [viewState, setViewState] = React.useState({
    longitude: -100,
    latitude: 40,
    zoom: 3.5
  });

  return <div>
    <AtlasMap viewState={viewState} setViewState={setViewState} />
    <div className="h-dvh max-w-md lg:p-10 lg:drop-shadow-lg">
      <div className="bg-white w-full h-full">
        <CountryList />
      </div>
    </div>
  </div>;
}