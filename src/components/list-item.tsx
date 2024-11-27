import * as React from 'react';
import { Icon } from '@iconify-icon/react';

export interface ListItemProps {
  title: string;
  count?: number;
  link: string;
}

export default function ListItem({ title, count, link } : ListItemProps) {
  return <li>
    <a className='px-5 py-6 flex items-center justify-between' href={link}>
      <div>{title}</div>
      <div>
        <span>{count}</span>
        <Icon icon="weui:arrow-filled" />
      </div>
    </a>
  </li>;
}