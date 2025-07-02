# BLE Integration Guide

This guide covers how to use and troubleshoot the BLE (Bluetooth Low Energy) integration features in PulsePath.

## Supported Devices

PulsePath supports heart rate monitors that implement the standard Heart Rate Service (0x180D):

### Tested Devices
- **Polar H10** - Premium accuracy, excellent RR interval support
- **Polar H9** - Good accuracy, reliable RR intervals
- **Garmin HRM-Pro** - Dual ANT+/BLE, good accuracy
- **Garmin HRM-Dual** - Basic BLE functionality
- **Wahoo TICKR** - Reliable basic heart rate monitoring
- **Apple Watch** - When paired via Bluetooth (limited RR interval accuracy)

### Device Compatibility Requirements
- Bluetooth Low Energy (BLE) 4.0 or higher
- Heart Rate Service (UUID: 0x180D) implementation
- Heart Rate Measurement characteristic (UUID: 0x2A37)
- RR interval support (optional but recommended for HRV analysis)

## Setup Instructions

### 1. Device Preparation
1. **Polar Devices**: 
   - Wet the sensor pads with water or electrode gel
   - Wear the strap snugly around your chest, just below the chest muscles
   - Ensure good contact between sensor and skin

2. **Garmin Devices**:
   - Moisten the sensor electrodes
   - Position the strap around your chest with the device centered
   - Check that the status light indicates proper connection

3. **Apple Watch**:
   - Ensure watchOS 6.0 or later
   - Enable Bluetooth on your phone
   - The watch should appear as a heart rate device when not paired to another phone

### 2. Pairing Process
1. Open PulsePath app
2. Navigate to **Dashboard** → **BLE Capture**
3. Tap **"Scan for Devices"**
4. Put your heart rate monitor in pairing mode (usually automatic when turned on)
5. Select your device from the discovered list
6. The device will be paired and ready for HRV capture

### 3. HRV Capture
1. Ensure your heart rate monitor is properly fitted and connected
2. Find a quiet, comfortable position (sitting or lying down)
3. Tap **"Start HRV Capture"**
4. Remain still and breathe normally for the 3-minute capture period
5. The app will automatically analyze your HRV data and display results

## Troubleshooting

### Connection Issues

**Device Not Found During Scan**
- Ensure your heart rate monitor is turned on and in pairing mode
- Move closer to the device (within 3 feet)
- Check that Bluetooth is enabled on your phone
- Restart the heart rate monitor by turning it off and on
- Clear Bluetooth cache: Settings → Apps → Bluetooth → Storage → Clear Cache (Android)

**Device Connects But Disconnects Immediately**
- Check battery level of heart rate monitor
- Ensure the device isn't already connected to another app or device
- Try forgetting and re-pairing the device
- Restart both the app and the heart rate monitor

**Poor Signal Quality**
- Check sensor contact with skin - should be snug but not too tight
- Moisten sensor pads if they appear dry
- Clean sensor pads with mild soap and water, then rinse and dry
- Check for interference from other electronic devices
- Ensure proper sensor placement (refer to device manual)

### Data Quality Issues

**Low HRV Quality Score**
- Remain as still as possible during capture
- Breathe normally - don't try to control your breathing
- Ensure heart rate monitor is properly fitted
- Avoid talking or moving during the measurement
- Check that sensor pads are making good contact

**Insufficient RR Intervals**
- Extend measurement time if using a device with poor RR interval support
- Switch to a higher-quality heart rate monitor (Polar H10 recommended)
- Check device battery level
- Ensure stable Bluetooth connection

**High Artifact Rate**
- Check heart rate monitor placement and contact
- Minimize movement during measurement
- Avoid electrical interference (phones, computers, etc.)
- Clean sensor pads and skin contact area

### Auto-Reconnect Issues

**Device Doesn't Auto-Reconnect**
- Check that auto-reconnect is enabled in app settings
- Verify the device is set as preferred device
- Ensure heart rate monitor is turned on and in range
- Check Bluetooth permissions for the app
- Restart the app if reconnection repeatedly fails

**Frequent Disconnections**
- Check heart rate monitor battery level
- Reduce distance between phone and heart rate monitor
- Close other Bluetooth-intensive apps
- Update heart rate monitor firmware if available
- Check for iOS/Android Bluetooth issues and restart if needed

## Advanced Features

### Device Settings
Access device-specific settings by:
1. Go to **Settings** → **BLE Devices**
2. Select your paired device
3. Configure options:
   - **Battery Monitoring**: Enable/disable battery level tracking
   - **Auto-Reconnect**: Configure automatic reconnection behavior
   - **Heart Rate Alerts**: Set up min/max heart rate notifications
   - **Connection Timeout**: Adjust how long to wait for connection
   - **Retry Attempts**: Number of automatic reconnection attempts

### Data Export
HRV data captured via BLE can be exported in multiple formats:
- **CSV**: For analysis in spreadsheet applications
- **JSON**: For programmatic analysis
- **PDF Report**: Human-readable summary with charts

### Quality Metrics
PulsePath provides real-time feedback on data quality:
- **Signal Quality**: Percentage of valid heart rate readings
- **Artifact Rate**: Percentage of data removed as artifacts
- **Data Sufficiency**: Whether enough data exists for reliable HRV analysis
- **RR Interval Count**: Number of heart rate intervals captured

## Technical Details

### Supported Bluetooth Services
- **Heart Rate Service (0x180D)**: Primary service for heart rate data
- **Battery Service (0x180F)**: Optional service for battery level monitoring
- **Device Information Service (0x180A)**: Optional service for device details

### Data Processing Pipeline
1. **Raw Data Collection**: RR intervals received from BLE device
2. **Quality Validation**: Physiological range checking and artifact detection
3. **Statistical Filtering**: Outlier removal using modified z-score method
4. **HRV Analysis**: Calculation of 14+ HRV metrics
5. **Score Generation**: Conversion to 0-100 Stress/Recovery/Energy scores

### Privacy & Security
- All heart rate data is encrypted locally using AES-256
- BLE device pairing information is stored securely
- No heart rate data is transmitted to third parties
- Users can opt for local-only storage (no cloud sync)

## Performance Tips

### Battery Optimization
- Close the app when not actively capturing HRV data
- Disable auto-reconnect if not needed for your workflow
- Use heart rate monitors with good battery life (Polar H10: ~400 hours)

### Accuracy Optimization
- Use chest strap monitors for best accuracy (not wrist-based)
- Ensure proper fit - tight enough for contact, loose enough for comfort
- Keep sensors clean and occasionally replace electrode pads
- Capture HRV at consistent times for comparable readings

### Connection Stability
- Keep heart rate monitor within 10 feet of phone during capture
- Avoid areas with heavy Bluetooth interference
- Ensure both devices have adequate battery levels
- Use heart rate monitors with good BLE implementation (Polar recommended)

## Supported HRV Metrics

When using BLE heart rate monitors, PulsePath calculates:

**Time Domain Metrics:**
- RMSSD (Root Mean Square of Successive Differences)
- Mean R-R intervals
- SDNN (Standard Deviation of NN intervals)
- pNN50 and pNN20 percentages

**Frequency Domain Metrics:**
- LF (Low Frequency) power
- HF (High Frequency) power
- LF/HF ratio
- Total Power

**Geometric Metrics:**
- Baevsky Stress Index
- Coefficient of Variance
- MxDMn (Max-Min difference)

**Non-linear Metrics:**
- DFA-α1 (Detrended Fluctuation Analysis)

## Getting Help

If you continue to experience issues:

1. **Check Device Compatibility**: Ensure your heart rate monitor supports BLE and Heart Rate Service
2. **Update Software**: Keep both PulsePath app and device firmware updated
3. **Contact Support**: Use in-app support with device logs for technical assistance
4. **Community**: Check user forums for device-specific tips and experiences

## Recommended Devices for Best Experience

**Premium Choice: Polar H10**
- Exceptional accuracy (±1ms RR intervals)
- Long battery life (400+ hours)
- Waterproof design
- Excellent BLE implementation

**Budget Choice: Polar H9**
- Good accuracy for HRV analysis
- Reliable BLE connection
- More affordable than H10
- Compatible with most fitness apps

**Multi-Sport: Garmin HRM-Pro**
- Dual ANT+ and BLE connectivity
- Running form metrics (when used with compatible devices)
- Good accuracy for HRV analysis
- Integrates well with Garmin ecosystem