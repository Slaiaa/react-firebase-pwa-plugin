import { render, screen } from '@testing-library/react';
import { axe, toHaveNoViolations } from 'jest-axe';
import { describe, expect, it } from 'vitest';
import { {{ComponentName}} } from './{{ComponentName}}';

expect.extend(toHaveNoViolations);

describe('{{ComponentName}}', () => {
  it('renders without crashing', () => {
    render(<{{ComponentName}}>Test content</{{ComponentName}}>);
    expect(screen.getByText('Test content')).toBeInTheDocument();
  });

  it('applies custom className', () => {
    render(<{{ComponentName}} className="custom-class">Content</{{ComponentName}}>);
    expect(screen.getByText('Content')).toHaveClass('custom-class');
  });

  it('passes through additional props', () => {
    render(<{{ComponentName}} data-testid="test-component">Content</{{ComponentName}}>);
    expect(screen.getByTestId('test-component')).toBeInTheDocument();
  });

  describe('accessibility', () => {
    it('has no accessibility violations', async () => {
      const { container } = render(<{{ComponentName}}>Accessible content</{{ComponentName}}>);
      const results = await axe(container);
      expect(results).toHaveNoViolations();
    });
  });
});
