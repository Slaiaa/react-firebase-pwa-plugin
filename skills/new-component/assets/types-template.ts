import type { HTMLAttributes, ReactNode } from 'react';

/**
 * Props for the {{ComponentName}} component
 */
export interface {{ComponentName}}Props extends HTMLAttributes<HTMLDivElement> {
  /** Content to render inside the component */
  children?: ReactNode;
  /** Additional CSS class names */
  className?: string;
}
