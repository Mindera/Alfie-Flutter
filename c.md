# C.MD
A file with useful commands


## Testing

```bash 
flutter test --coverage --branch-coverage
genhtml coverage/lcov.info -o coverage/html --branch-coverage --ignore-errors inconsistent
```

## Deeplinking

### iOS
```bash
app://alfie.com/{app_route} (inside notes or clickable link)
```

### Android
```bash
adb shell am start -a android.intent.action.VIEW -d "app://alfie.com/{app_route}" (in terminal)
```