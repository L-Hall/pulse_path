# PulsePath – Liquid Glass UI Implementation Plan

*Version 1.0 – 28 Jun 2025*

---

## Purpose

This document explains **how to integrate Apple’s new Liquid Glass design language** (announced WWDC 2025 for iOS 26 & watchOS 26) into PulsePath’s Flutter-based iOS and watchOS apps. It covers design‑system updates, native bridging, Flutter widget architecture, performance safeguards and rollout timeline so that a junior developer can start work immediately.

---

## 1  |  Background & Goals

Apple’s Liquid Glass aesthetic introduces translucent, dynamically tinted materials with real‑time specular highlights that adapt to wallpaper colours, light/dark mode and device motion. Implementing it will:

* Give PulsePath a native, premium feel on iOS26/watchOS26.
* Align UI with Apple’s updated HIG, improving App Store review confidence.
* Maintain a **single Flutter code‑base** while falling back gracefully on older iOS and all Android devices.

---

## 2  |  Design‑System Deliverables

| Task                                                                                               | Owner  | Output                                    |
| -------------------------------------------------------------------------------------------------- | ------ | ----------------------------------------- |
| **Colour tokens** – add `liquid-primary`, `liquid-secondary` (dynamic tint sampled from wallpaper) | Design | Updated design‑tokens JSON & Figma Styles |
| **Glass layer style** – 28 px blur, 12 % white overlay (light) / 18 % black (dark), 8 dp radius    | Design | Figma Effect Style                        |
| **Elevation scale** – Glass‑00 … Glass‑06 mapping to blur/overlay/ shadow values                   | Design | Figma grid & documentation                |
| **Motion spec** – Specular parallax ≤ 6 pt; spring 250 ms, damping 0.8                             | Design | Lottie JSON keyframes                     |
| **Icons** – Rebuild glyphs with Icon Composer (clear/dark/tint)                                    | Design | `assets/icons/liquid/` SVG & PDF          |

> **Tip:** export design‑tokens as `tokens.json` so Flutter’s `style_dictionary` can generate Dart constants.

---

## 3  |  Architecture Overview

```
lib/
 └─ widgets/
     ├─ liquid_glass_container.dart   # shared fallback (blur + tint)
     ├─ liquid_glass_button.dart
     └─ ...
ios/Classes/
 └─ LiquidGlassViewFactory.swift     # wraps UILiquidGlassMaterial
watchos/Extension/
 └─ LiquidGlassTile.swift            # native SwiftUI tile
```

* **Flutter widgets** call a platform view on iOS 26+; older iOS/Android use BackdropFilter.
* **watchOS** gets a native SwiftUI extension for performance & complications.

---

## 4  |  Native Bridges

### 4.1  iOS 26+

* **API:** `UILiquidGlassMaterial` (`UIKit`) / `LiquidGlassMaterial()` (`SwiftUI`).
* Create a `LiquidGlassViewFactory` implementing `FlutterPlatformView`.
* Pass parameters via `creationParams` (elevation, tint RGB).
* Bridge method‑channel `liquidGlass#setTint` to update when wallpaper changes.

### 4.2  watchOS 26

* Independent SwiftUI app/complication using `LiquidGlassMaterial()`.
* Communicate with phone via `WCSession` (`watch_bridge` channel).

### 4.3  Fallback (≤ iOS25 & Android)

* Flutter `BackdropFilter` blur + semi‑transparent tint from accent colour.
* Disable motion‑driven specular animation.

---

## 5  Shared Flutter Widgets (excerpt)

```dart
class LiquidGlassContainer extends StatelessWidget {
  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.elevation = 1,
  });
  final Widget child;
  final int elevation;

  @override
  Widget build(BuildContext context) {
    final ios26 = Platform.isIOS && DeviceInfo.iosVersion >= 26;
    if (ios26) {
      return UiKitView(
        viewType: 'liquid_glass_view',
        creationParams: {'elevation': elevation},
        creationParamsCodec: const StandardMessageCodec(),
        child: child,
      );
    }
    // Fallback path
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: ColoredBox(
          color: _dynamicTint(context).withOpacity(0.12 * (elevation + 1)),
          child: child,
        ),
      ),
    );
  }
}
```

---

## 6  Performance & Accessibility

* **Metal‑backed blurs**: set `layer.isOpaque = false`; cache raster when static.
* Limit simultaneous iOS LiquidGlass layers to ≤ 3.
* On devices < A14 chip, fall back to static blurred snapshot while scrolling.
* Use `accessibilityPerformsEscape` to ensure blur does not hinder VoiceOver.
* Verify contrast ratio ≥ 4.5:1 behind translucent surfaces.

---

## 7  Roll‑out Timeline (6 sprints)

| Sprint  | Deliverable                                                                 |
| ------- | --------------------------------------------------------------------------- |
| **S‑0** | Finalise Figma tokens, motion spec & export scripts                         |
| **S‑1** | Implement `LiquidGlassContainer`, blur fallback verified on iOS/Android     |
| **S‑2** | Build iOS native `UILiquidGlassMaterial` bridge; integrate on Dashboard     |
| **S‑3** | Convert nav/tab bars; implement morph on scroll; start GPU profiling        |
| **S‑4** | watchOS SwiftUI tile + HRV complication using Liquid Glass                  |
| **S‑5** | Icon swap, full QA (golden/HDR), accessibility audit, App Store screenshots |

---

## 8  Dependencies Update Checklist

* **Flutter ≥4.1** – watchOS flag enabled.
* `cupertino_icons: ^2.0.0-lg` – Liquid Glass glyphs.
* Remove `glassmorphism` package.
* Add `golden_toolkit: ^0.16.0` for blur golden tests.
* Fastlane lanes for watchOS build & TestFlight.

---

## 9  Next Steps for Junior Dev

1. **Clone design tokens** from Figma → run `style_dictionary build` to generate `liquid_theme.dart`.
2. Scaffold `LiquidGlassContainer` & fallback path (see code above).
3. Experiment with `UILiquidGlassMaterial` in a small Swift wrapper app before integrating via PlatformView.
4. Coordinate with Design to import motion spec into `rive`/Lottie if we choose animated highlights.
5. Document any performance regressions in the GPU frame‑timing log.

*Questions? – Ping the UI Tech Lead in the `#pulsepath-ios` Slack channel.*
