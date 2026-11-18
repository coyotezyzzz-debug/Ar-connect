---
name: AeroPure Marketplace
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#3f4850'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#707881'
  outline-variant: '#bfc7d2'
  surface-tint: '#006398'
  primary: '#006194'
  on-primary: '#ffffff'
  primary-container: '#007bb9'
  on-primary-container: '#fdfcff'
  inverse-primary: '#93ccff'
  secondary: '#565e74'
  on-secondary: '#ffffff'
  secondary-container: '#dae2fd'
  on-secondary-container: '#5c647a'
  tertiary: '#006387'
  on-tertiary: '#ffffff'
  tertiary-container: '#007da9'
  on-tertiary-container: '#fcfcff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#cce5ff'
  primary-fixed-dim: '#93ccff'
  on-primary-fixed: '#001d31'
  on-primary-fixed-variant: '#004b73'
  secondary-fixed: '#dae2fd'
  secondary-fixed-dim: '#bec6e0'
  on-secondary-fixed: '#131b2e'
  on-secondary-fixed-variant: '#3f465c'
  tertiary-fixed: '#c4e7ff'
  tertiary-fixed-dim: '#7bd0ff'
  on-tertiary-fixed: '#001e2c'
  on-tertiary-fixed-variant: '#004c69'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 48px
    fontWeight: '800'
    lineHeight: 56px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 36px
    fontWeight: '800'
    lineHeight: 44px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.015em
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 26px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.015em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.005em
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.03em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1.5rem
  gutter-mobile: 1rem
  margin: 2rem
  margin-mobile: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2.5rem
---

## Brand & Style

The design system establishes a high-trust, hygienic, and precise aesthetic tailored for climate control, HVAC maintenance, and air purification services. It bridges technical competence with domestic and commercial reliability, addressing both high-stakes commercial facilities and everyday homeowners.

The design movement combines **Modern Utility** with **Crisp Tonal Layering**. It draws cues from high-grade technical equipment interfaces and cleanroom environments: generous internal whitespace, crisp tactile feedback, pristine contrast, and soft structural curves that soften industrial rigidity while preserving rigorous professionalism. Visual density is balanced to allow rapid scanning of technician credentials, quote breakdowns, and system telemetry without visual fatigue.

## Colors

The palette is engineered to communicate thermal control, fresh air circulation, and structural dependability.

- **Primary (`#0284C7` - Clean Cyan / Sky)**: Represents active airflow, freshness, and immediate operational momentum. Reserved for primary calls to action, active navigation targets, price highlights, and focus outlines.
- **Secondary (`#0F172A` - Deep Marine)**: The structural anchor. Conveys institutional trust, technical expertise, and solid grounding. Applied to primary headings, primary high-priority buttons in commercial flows, and grounding panels.
- **Tertiary (`#38BDF8` - Atmospheric Breeze)**: Light cyan supporting tone, used for highlight chips, soft container borders, badge accents, and interactive hover states.
- **Neutral (`#64748B` - Slate Core)**: Provides legible, low-glare utility across borders, secondary descriptions, table metadata, and inactive controls.

### Functional Status Tokens
- **Success (`#10B981`)**: Concluded services, certified technician verification, approved quotes.
- **Warning / Pending (`#F59E0B`)**: Awaiting technician response, pending estimate approval, scheduled inspection alerts.
- **Critical / Urgent (`#EF4444`)**: Emergency breakdown, cancelled bookings, coolant leak alerts.
- **Neutral Surface Canvas (`#F8FAFC`)**: Ultra-clean, cool-tinted backdrop evoking sanitized environments.

## Typography

The typographic hierarchy relies on **Plus Jakarta Sans** for expressive, human yet architectural headings and body copy, paired with **Inter** for dense metadata, technical specs, tabular figures, and badges.

- **Plus Jakarta Sans**: Smooth geometrical forms communicate modern approachability without losing engineering discipline. The tight negative tracking on display and headline weights provides visual density and clarity across marketing and dashboard surfaces.
- **Inter**: Used across interface controls, status tags, numerical ratings, price tiers, and parameter tables to maintain maximum legibility under rapid inspection. Numeric tabular lining (`font-variant-numeric: tabular-nums`) must be enforced for all currency metrics, technician ratings, and schedule timestamps.

## Layout & Spacing

The layout is built upon an 8-point base rhythm using a fluid, responsive 12-column grid system designed for transactional clarity.

- **Desktop (1024px+)**: 12-column grid with `1.5rem` (24px) gutters and a max-width container capped at `1280px` for marketplace browsing, expandable to full-bleed with `2rem` (32px) margins in admin and dispatch panels.
- **Tablet (768px - 1023px)**: 8-column layout with `1.25rem` gutters and `1.5rem` margin. Filter sidebars collapse into a floating trigger sheet.
- **Mobile (< 768px)**: 4-column layout with `1rem` gutters and `1rem` lateral margins. Filter systems convert into sticky bottom sheets.
- **Rhythm Rules**: Internal card padding strictly uses `space-lg` (`1.5rem`) on desktop and `space-md` (`1rem`) on mobile. Sibling spacing in lists defaults to `space-md`, while major semantic sections maintain `space-xl` separation to avoid cognitive clutter.

## Elevation & Depth

Visual depth is achieved through **pristine tonal layering** combined with **subtle atmospheric diffusion**, avoiding heavy or muddy shadows to reflect an immaculate, climate-controlled environment.

- **Level 0 (Flat / Canvas)**: Base surface color `#F8FAFC`. Used for full-page background screens.
- **Level 1 (Card & Section Containers)**: `#FFFFFF` surface with a delicate 1px border in `#E2E8F0` and an ambient shadow: `box-shadow: 0 1px 3px 0 rgba(15, 23, 42, 0.04), 0 1px 2px -1px rgba(15, 23, 42, 0.02)`.
- **Level 2 (Interactive Cards / Technician Profiles Hover)**: `#FFFFFF` surface with border `#CBD5E1` and an elevated cool shadow: `box-shadow: 0 10px 15px -3px rgba(15, 23, 42, 0.06), 0 4px 6px -4px rgba(2, 132, 199, 0.05)`.
- **Level 3 (Modals, Overlays & Drawers)**: High-altitude surface `#FFFFFF` elevated by `box-shadow: 0 20px 25px -5px rgba(15, 23, 42, 0.1), 0 8px 10px -6px rgba(15, 23, 42, 0.05)`, backed by a cool dark scrim `rgba(15, 23, 42, 0.45)` with `backdrop-filter: blur(4px)`.

## Shapes

The interface embraces a clean, softened geometry that balances machine precision with consumer accessibility. 

- **Containers & Technician Cards**: Configured with `rounded-xl` (`1rem` / 16px) or `rounded-2xl` (`1.5rem` / 24px) for expansive modular cards. This eliminates harsh corners while providing substantial visual grouping.
- **Action Elements & Inputs**: Primary buttons, filter pills, dropdown controls, and text inputs utilize `rounded-lg` (`0.75rem` / 12px) to guarantee clean touch targets.
- **Badges & Status Tags**: Fully pill-shaped (`9999px`) to immediately distinguish operational markers and verification tags from interactive inputs.

## Components

### Buttons
- **Primary**: Deep Blue background (`#0F172A`) or Vivid Cyan (`#0284C7`), text white, `rounded-lg` with `0.75rem` horizontal and `0.625rem` vertical padding. Hover transitions smoothly to 10% darker with a subtle elevation shift.
- **Secondary / Outline**: Clean `#FFFFFF` fill with 1px border `#CBD5E1`, text `#0F172A`. On hover: border `#0284C7`, text `#0284C7`, background `#F0F9FF`.
- **Destructive**: Pale red background `#FEF2F2`, border `#FECACA`, text `#DC2626`.

### Badges & Status Indicators
Badges are styled as pill chips with low-opacity tinted backgrounds, crisp borders, and a preceding 6px solid status dot:
- **Aguardando Resposta (Awaiting Response)**: Background `#FFFBEB`, text `#B45309`, border `#FDE68A`, dot `#F59E0B`.
- **Aceito (Accepted)**: Background `#EFF6FF`, text `#1D4ED8`, border `#BFDBFE`, dot `#3B82F6`.
- **Agendado (Scheduled)**: Background `#F0FDF4`, text `#15803D`, border `#BBF7D0`, dot `#22C55E`.
- **Em Andamento (In Progress)**: Background `#F0F9FF`, text `#0369A1`, border `#BAE6FD`, animated pulsing dot `#0284C7`.
- **Concluído (Completed)**: Background `#ECFDF5`, text `#047857`, border `#A7F3D0`, dot `#10B981`.

### Technician Cards
- **Structure**: Surface `#FFFFFF`, border 1px `#E2E8F0`, corner radius `1rem`. Divided into identity, credentials, metrics, and immediate booking action.
- **Profile Avatar**: 64x64px photo with an absolute-positioned green checkmark verification badge at bottom-right.
- **Star Ratings**: Star icon colored `#F59E0B` accompanied by bold decimal text (`4.9`) and muted review count (`(128 avaliações)` in `body-sm`).
- **Specialty Tags**: Micro-chips with `#F1F5F9` background and `#334155` text detailing certifications (e.g., "Inverter", "VRF", "Higienização Hospitalar").

### Input Fields & Search Bars
- **Text Inputs**: Height 44px, background `#FFFFFF`, border 1px `#CBD5E1`, rounded `0.75rem`. Text color `#0F172A`. Placeholder `#94A3B8`. Active focus rings apply `2px solid #0284C7` with a `0 0 0 3px rgba(2, 132, 199, 0.15)` aura.
- **Address & Capacity Range Selectors**: Integrated dual-segment controls with leading icons (location pin, BTU/cooling capacity gauges) rendered in `#64748B`.

### Checkboxes & Radio Buttons
- Custom square (`6px` radius) and circular controls using `#0284C7` on checked states with sharp white tick/dot glyphs. Unchecked borders reside in `#CBD5E1`.

### Filter Panel
- Filter sections grouped by collapsable accordion headers featuring toggle tags (e.g., "Atendimento 24h", "Peças Originais", "Garantia 90 dias", "Classificação 4.5+"). Active filters display in solid `#0284C7` with inverted white text and clear `x` dismiss triggers.