---
name: Vital Glass
colors:
  surface: '#f6fafe'
  surface-dim: '#d6dade'
  surface-bright: '#f6fafe'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f0f4f8'
  surface-container: '#eaeef2'
  surface-container-high: '#e4e9ed'
  surface-container-highest: '#dfe3e7'
  on-surface: '#171c1f'
  on-surface-variant: '#404752'
  inverse-surface: '#2c3134'
  inverse-on-surface: '#edf1f5'
  outline: '#707883'
  outline-variant: '#bfc7d4'
  surface-tint: '#0061a4'
  primary: '#0061a4'
  on-primary: '#ffffff'
  primary-container: '#2196f3'
  on-primary-container: '#002c4f'
  inverse-primary: '#9ecaff'
  secondary: '#8b5000'
  on-secondary: '#ffffff'
  secondary-container: '#ff9800'
  on-secondary-container: '#653900'
  tertiary: '#006876'
  on-tertiary: '#ffffff'
  tertiary-container: '#00a0b5'
  on-tertiary-container: '#003037'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d1e4ff'
  primary-fixed-dim: '#9ecaff'
  on-primary-fixed: '#001d36'
  on-primary-fixed-variant: '#00497d'
  secondary-fixed: '#ffdcbe'
  secondary-fixed-dim: '#ffb870'
  on-secondary-fixed: '#2c1600'
  on-secondary-fixed-variant: '#693c00'
  tertiary-fixed: '#a1efff'
  tertiary-fixed-dim: '#44d8f1'
  on-tertiary-fixed: '#001f25'
  on-tertiary-fixed-variant: '#004e59'
  background: '#f6fafe'
  on-background: '#171c1f'
  surface-variant: '#dfe3e7'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: '1.1'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: '1.2'
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: '1.2'
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: '1.4'
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.5'
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: '1'
    letterSpacing: 0.05em
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  base: 8px
  container-padding: 24px
  gutter: 16px
  card-gap: 12px
  section-margin: 32px
---

## Brand & Style

The design system is engineered for the high-performance health-tech sector, specifically targeting longevity, bio-optimization, and clinical tracking. The brand personality is **clinical yet hyper-modern**, bridging the gap between rigorous scientific labs and lifestyle-integrated wellness.

The visual style is defined as **High-Tech Glassmorphism**. It utilizes a layered architecture of translucent surfaces, vibrant mesh gradients, and 3D scientific assets to evoke a sense of transparency and precision. The emotional response is one of clarity and optimism—patients and biohackers should feel they are interacting with sophisticated, future-ready medical technology that remains accessible and human-centric.

## Colors

The palette is anchored by **Tech Blue**, a high-chroma primary that signifies medical reliability and digital innovation. **Energizing Orange** serves as a vital highlight, used sparingly for progress peaks, call-to-actions, and "active" physiological states.

- **Primary (Tech Blue):** Used for core branding, navigation icons, and primary action buttons.
- **Secondary (Energizing Orange):** Reserved for highlights, urgency, and achievement metrics.
- **Tertiary (Cyan/Bio-Teal):** Used for auxiliary data points and DNA-related visual metaphors.
- **Backgrounds:** A crisp "Clean White" (#FFFFFF) for cards and "Soft Slate" (#F0F4F8) for global app backgrounds to provide contrast for the glass effects.

## Typography

This design system utilizes **Inter** for its exceptional legibility in data-dense environments. The typographic hierarchy emphasizes clarity and immediate scanning. 

Headers are tight and bold to create a sense of confidence, while body text uses a generous line height (1.6) to reduce cognitive load during medical data review. For labels and metadata, an uppercase styling is preferred to maintain the "instrumental" or "dashboard" aesthetic of medical hardware.

## Layout & Spacing

The layout philosophy follows a **Fluid Grid** with generous safe margins to accommodate the "floating" nature of glassmorphic cards. 

- **Mobile:** A single column layout with 24px side margins. Cards often span the full width or appear in 2x2 grids for quick-action buttons.
- **Desktop:** A 12-column grid with a maximum content width of 1200px. High-level health metrics occupy the wider spans (8 columns), while secondary controls and logs sit in the sidebars (4 columns).
- **Rhythm:** An 8px base unit drives all padding and margins to ensure a consistent vertical rhythm.

## Elevation & Depth

Depth in this design system is achieved through **Glassmorphism and Tonal Layering** rather than traditional heavy shadows.

1.  **Background Layer:** Smooth mesh gradients of Tech Blue and White.
2.  **Glass Panels:** 20-40% opacity white fills with a 20px background blur. These have a 1px "inner light" border (White, 30% opacity) to catch the light at the edges.
3.  **Floating Elements:** Elements like 3D molecules or DNA strands sit between layers, partially obscured by glass panels to create a 3D "aquarium" effect.
4.  **Shadows:** Shadows are "Ambient Blue"—very low opacity (#2196F3 at 8%) with a large spread (32px) to make cards feel like they are levitating over the background.

## Shapes

The shape language is defined by **Extreme Radii**. To counteract the coldness of clinical data, large corner radii (24px to 32px) are applied to all primary containers. This creates a "friendly-tech" aesthetic that feels soft and organic, much like the biological systems the app monitors.

Secondary elements like icons or input fields use a consistent 12px-16px radius, ensuring they feel like a family of parts within the larger containers.

## Components

### Buttons & Chips
- **Action Cards:** Large, pill-shaped or highly rounded blocks with vibrant color fills (Blue or Orange) and a subtle inner-glow icon in a frosted square.
- **Status Chips:** Small frosted glass containers with a colored dot indicating "On Track" (Primary) or "Urgent" (Secondary).

### Cards
- **Main Container:** 24px-32px corner radius, background blur (20px), and a subtle drop shadow.
- **Inner Content:** Information should be padded by 20px minimum from the card edge.

### Inputs & Fields
- Input fields use "Frosted Glass" backgrounds. On focus, the 1px border transitions from translucent white to solid Tech Blue.

### Data Visualization
- **Wave Indicators:** Progress is visualized through organic wave shapes rather than harsh bars.
- **Ring Indicators:** Multi-layered circular progress bars with glowing ends.

### Imagery
- Use high-fidelity 3D assets of medical icons. These should have a "glass" or "plastic" texture with internal refractions to match the UI style.