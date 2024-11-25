import * as React from 'react';
import { Icon } from '@iconify-icon/react';
import { type Url } from 'url';

export interface ListItemProps {
  title: string;
  count: number;
  link: Url
}

export default function ListItem({ title, count, link }) {
  return <a className='px-5 py-6 flex items-center justify-between' href={link}>
    <div>{title}</div>
    <div>{count}</div>
    <Icon icon="weui:arrow-filled" />
  </a>;
}