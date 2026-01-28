# C.MD
A file with useful commands

## Branching
Remove deleted origin branches: 
```bash
git fetch -p
```

View branches with deleted origin: 
```bash
git branch -vv
```

Delete all branches with deleted origins
```bash
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d
```

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