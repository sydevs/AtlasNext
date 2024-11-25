import * as React from 'react';
import ListItem from '../list-item';

import * as schema from '/drizzle/schema';
import { drizzle } from 'drizzle-orm/...';

export interface CountryListProps {
  country: number;
}

export default function CountryList({ country }) {

  return <a className='px-5 py-6 flex items-center justify-between' href={link}>
    <div>{title}</div>
    <div>{count}</div>
    <Icon icon="weui:arrow-filled" />
  </a>;
}