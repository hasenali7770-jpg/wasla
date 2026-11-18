# Wasla (وصلة) — Brand Kit v2 (FINAL)

Replaces v1 (chat bubbles). Do not use v1 files.

Logo concept: two interlocking rings, yellow and green, like links of a chain — "وصلة" literally means "link".

## Colors

| Name        | Hex       | Use                                              |
|-------------|-----------|--------------------------------------------------|
| Black       | `#111111` | Icon background, dark theme background, text     |
| Yellow      | `#F7C531` | Accent: highlights, badges, outgoing bubble      |
| Green       | `#12823F` | Brand green: icon ring, large text, illustrations |
| Deep Green  | `#0F6E35` | Buttons and app bar with white text (contrast 6.4:1) |
| White       | `#FFFFFF` | Light theme background, text on dark             |

Accessibility notes:
- White text on `#12823F` is 4.4:1 — below WCAG AA for normal text. Use `#0F6E35` for buttons/app bar with white text.
- Black text on Yellow is 11.7:1 — fine for badges and chips.

## Typography

- **Cairo** (Google Fonts, OFL license) for Arabic and Latin UI.
- Wordmark: "وصلة" in Cairo ExtraBold (800); Latin "Wasla" in Cairo SemiBold, letter-spacing 0.08em.
  On black: wordmark in Yellow. On white: wordmark in Black or Deep Green.

## Files

| File | Use |
|------|-----|
| `wasla-icon-square.svg` | Master icon, full-bleed square |
| `wasla-icon-1024.png` | iOS App Store icon (1024×1024, no alpha) |
| `wasla-icon-512.png` | Google Play store listing icon (512×512, no alpha) |
| `wasla-icon-rounded.svg` / `wasla-icon-rounded-1024.png` | Rounded version for website, docs, social |
| `android-adaptive-foreground.svg` / `-432.png` | Android adaptive icon foreground (transparent, inside safe zone) |
| `android-monochrome.svg` / `-432.png` | Android 13+ themed icon |

Android adaptive icon background: solid `#111111`.

## Flutter setup (flutter_launcher_icons)

Copy the PNGs to `app/assets/brand/`, then in `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.0

flutter_launcher_icons:
  android: "ic_launcher"
  ios: true
  remove_alpha_ios: true
  image_path: "assets/brand/wasla-icon-1024.png"
  adaptive_icon_background: "#111111"
  adaptive_icon_foreground: "assets/brand/android-adaptive-foreground-432.png"
  adaptive_icon_monochrome: "assets/brand/android-monochrome-432.png"
```

Run: `dart run flutter_launcher_icons`

Theme: primary `#0F6E35`, secondary `#F7C531`, dark surface `#111111`, light surface `#FFFFFF`.
