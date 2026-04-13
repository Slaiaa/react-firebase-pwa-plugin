import React from 'react';
import styles from './{{ComponentName}}.module.css';
import type { {{ComponentName}}Props } from './types';

/**
 * {{ComponentName}} - {{description}}
 *
 * @example
 * ```tsx
 * <{{ComponentName}} />
 * ```
 */
export const {{ComponentName}}: React.FC<{{ComponentName}}Props> = ({
  children,
  className,
  ...props
}) => {
  return (
    <div
      className={`${styles.container} ${className ?? ''}`}
      {...props}
    >
      {children}
    </div>
  );
};

{{ComponentName}}.displayName = '{{ComponentName}}';
