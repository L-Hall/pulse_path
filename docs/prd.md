# PulsePath — Product Requirements Document (PRD)

*Version 0.5 — 28 Jun 2025*

*Owner: Product Lead*

---

## 1. Executive Summary

PulsePath is a cross-platform (iOS & Android) wellbeing app that uses **3-minute heart-rate-variability (HRV) readings** plus passively collected lifestyle signals (steps, workouts, menstrual cycle) to give users real-time **Stress, Recovery and Energy** scores.

A default **Adaptive Pacing Mode** (optimised for chronic–illness recovery) is enabled for everyone and can be switched off by users who do **not** need such guidance.

The app ships with **encrypted cloud sync** (opt-out) so data are backed-up and usable on any signed-in device. Regulatory certification is **not** pursued.

---

## 2. Goals & Non-Goals

| Type | In scope | Out of scope |
| --- | --- | --- |
| **G1** | Transparent HRV-based scoring with open formulas & citations. | Clinical diagnosis or treatment claims. |
| **G2** | Daily & weekly trend dashboards with actionable tips. | Fully fledged training-plan periodisation (v 2). |
| **G3** | Data ingestion from Apple Health, Google Fit, common BLE wearables, steps, workouts & menstrual cycle. | Rare proprietary devices (backlog). |
| **G4** | Affordable freemium pricing (< £6 / month) + one-off licence. | Enterprise/B2B portals. |
| **G5** | Privacy-first design (GDPR compliant, no third-party ad SDKs). | Selling or sharing user biometrics with advertisers. |
| **G6** | End-to-end–encrypted cloud sync with opt-out local-only mode. | Data-donation or research dashboards. |

**Success criteria:** 75 % four-week retention & NPS > 40 by month 6.

---

## 3. Personas

*(unchanged)*

---

## 4. High-Level User Stories (MoSCoW)

**Must**

1. As a **user**, I can record a **3-minute HRV reading** via phone camera or paired wearable.
2. I see today’s **Stress, Recovery and Energy** scores (0–100) with colour coding.
3. I can drill into **all metrics** (RMSSD, Mean R-R, SDNN, LF, HF, LF/HF, Baevsky index, Coefficient of Variance, MxDMn, Moda, AMo50, pNN50/20, Total Power, DFA-α1) with plain-English explanations.
4. My readings sync securely to the cloud and appear on any device I sign into (unless I turn sync off).
5. I receive a daily push notification summarising trends and suggesting next actions.

**Should**

6. Passive import of **steps, workouts and menstrual-cycle data** from HealthKit / Google Fit.

7. Adaptive Pacing Mode (default) can be toggled **off** if I’m not chronically ill.

8. I can export my raw data as CSV / JSON on demand.

**Could**

9. Attach journal notes or symptom tags to each reading.

**Won’t (v 1)**

10. Social leaderboards, smartwatch native app or AI chat coach.

11. Any research-data sharing or CE-mark workflows.

---

## 5. Functional Requirements

| ID | Description | Priority | Acceptance criteria |
| --- | --- | --- | --- |
| **FR-01** | **3-minute** PPG HRV reading via rear camera (adaptive flash). | **Must** | ≥ 95 % success on supported phones; HRV within ± 10 ms RMSSD vs Polar H10. |
| **FR-02** | BLE wearable integration (Polar, Garmin HRM-Pro, Apple Watch broadcast). | **Must** | Pair/unpair flow; ≥ 100 Hz stream. |
| **FR-03** | **Encrypted cloud sync** (Firebase Auth + Firestore + client-side AES). | **Must** | Multi-device continuity; opt-out switch; full offline parity. |
| **FR-04** | **Metrics engine v 1.0** implementing **all listed metrics**. | **Must** | Unit tests pass vs reference vectors; surfaced in UI. |
| **FR-05** | Home dashboard: three cards + trend graph + metric drill-downs. | **Must** | Loads < 400 ms on mid-range device. |
| **FR-06** | Local encryption of biometric data (AES-256) + optional iCloud/Drive backup. | **Must** | No plaintext exposure in pen-test. |
| **FR-07** | Subscription paywall ( £5.99 / mo, £39.99 / yr, lifetime £99). | **Should** | StoreKit & Play Billing pass review; restore purchases works. |
| **FR-08** | **Adaptive Pacing Mode** default-on; toggle off in settings. | **Should** | When active, PEM-risk badge appears on dashboard. |
| **FR-09** | HealthKit / Google Fit import of steps, workouts and menstrual cycle. | **Should** | Data ingested daily; visible in context cards. |

---

## 6. Non-Functional Requirements

| Category | Target |
| --- | --- |
| **Performance** | Cold-start < 2 s; widget build ≤ 16 ms/frame. |
| **Accessibility** | WCAG 2.1 AA. |
| **Security** | End-to-end TLS 1.3; client-side AES for cloud payloads; OWASP MASVS L1. |
| **Offline-first** | Full feature parity offline; queued sync when online. |
| **Localisation** | EN-GB & EN-US in v 1 (strings externalised). |

---

## 7. KPIs & Analytics Plan

| Metric | Target (6 mo) |
| --- | --- |
| **Day-7 retention** | 55 % |
| **Avg weekly HRV reads / user** | ≥ 5 |
| **Subscription conversion (30 d)** | 4 % |
| **Multi-device active ratio** | ≥ 25 % |
| **Crash-free sessions** | ≥ 99.5 % |

Analytics via Firebase + self-hosted Plausible (no third-party ads).

---

## 8. Dependencies & Risks

| Risk | Mitigation |
| --- | --- |
| Camera PPG accuracy varies by hardware. | Maintain device whitelist; recommend chest-strap pairing. |
| Cloud-security breach. | Zero-knowledge encryption; independent audit pre-launch. |
| Menstrual-cycle data permission complexity. | Granular consent screen; option to skip cycle tracking. |

---

## 9. Milestones

| Phase | Dates (T = kick-off) | Deliverables |
| --- | --- | --- |
| **Discovery** | T + 2 w | Persona validation; metric-engine spec v 0.9. |
| **Alpha** | T + 8 w | 3-min PPG capture; metrics engine; local store. |
| **Beta-1** | T + 14 w | Cloud sync, wearable support, Adaptive Pacing UI, paywall. |
| **Public Beta** | T + 20 w | Store internal testing; analytics dashboards. |
| **Launch v 1.0** | T + 24 w | Global release; marketing site. |

---

## 10. Open Items

None critical.

---

*End of PRD*